
HashMap<String,Float> hm = new HashMap<String,Float>();

int strokeMin, strokeMax, controlsWidth, canvasOffset,
    gripSize, bloat, padding, xHints[];
color gripColor, controlsBG, gripGlow, glowBG;

Slider[] sliders;


void setup() {

    String[] sliderNames = {"Hue", "Sat", "Bright", "Alpha", "Radius", "Rate"};
    int sCount = sliderNames.length;
    sliders = new Slider[sCount];

    size(900, 480);
    frameRate(24);
    strokeWeight(16);
    colorMode(HSB);

    bloat = height/6;
    padding = bloat/2;

    xHints = new int[4];

    xHints[0] = controlsWidth = height >> 1;
    xHints[1] = controlsWidth + bloat;
    xHints[2] = canvasOffset = xHints[1] + strokeMax;
    xHints[3] = width;

    gripColor = color(128);
    gripGlow = color(24,80,192); 
    controlsBG = color(50);
    glowBG = color(24,60,80);
    strokeMax = 64;
    strokeMin = 4;
    gripSize = 16;

    background(0);

    int[][] relValue = {{ 0, 255, 160 }, { 0, 255, 80  }, { 0, 255, 224 },
                        { 0, 255, 240 }, { 4,  64, 16  }, { 16, 60, 32  }};
    
    for(int i = 0; i < sCount; i++) {
        sliders[i] = new Slider(
            sliderNames[i], 0, controlsWidth, (bloat * i)+padding,
            relValue[i][0], relValue[i][1], float(relValue[i][2])
        );
        sliders[i].update();
        sliders[i].drawSelf();
    }

}


int focusedArea() {
    if(focused) {
        for(int i = 0; i < xHints.length; i++) {
            if(mouseX < xHints[i]) { return i; }
        }
        return 3;
    }
    return 4;
}            


void mouseReleased() {
    for(int i = 0; i < sliders.length; i++) {
        sliders[i].clearDrag();
        sliders[i].update();
    }
}


void draw() {
    if(mousePressed) {
        switch(focusedArea()) {
            case 0:
                int n = int(mouseY/bloat);
                if(sliders[n].hovering()) { sliders[n].setDragging(); }
                else if(sliders[n].dragging()) { sliders[n].drag(); }
                break;
            case 3:
                frameRate(hm.get("Rate"));
                pushStyle();
                    stroke(
                        hm.get("Hue"),    hm.get("Sat"),
                        hm.get("Bright"), hm.get("Alpha")
                    );
                    float r = hm.get("Radius");
                    r -= constrain(
                            dist(pmouseX,pmouseY, mouseX,mouseY),
                            strokeMin, r
                    );
                    strokeWeight(r);
                    point(mouseX, mouseY);
                popStyle();
                pushStyle();
                    noStroke();
                    fill(0);
                    rect(controlsWidth, 0, strokeMax, height);
                popStyle();
                break;
        }
    }
}


public class Slider {

    public String ident;
    int xMin, xMax, vMin, vMax, hMin, hMax, hPos, yOff;
    public float vNow;
    public boolean drag, hover;
    
    Slider(String s, int x1, int x2, int y, int v1, int v2, float cur) {
        ident = s;  yOff = y;  vNow = cur;
        xMax = x1; xMax = x2; hMin = x1 + padding;
        vMin = v1; vMax = v2; hMax = x2 - padding;
        hPos = int(map(cur, v1, v2, hMin, hMax));
    }

    void update() {
        vNow = map(hPos, xMin, xMax, vMin, vMax);
        hm.put(ident, vNow);        
    }

    public float getVal() { return vNow; }

    public boolean hovering() {
        if(drag) { return false; }
        else { return dist(mouseX, mouseY, hPos, yOff) < gripSize; }
    }

    public boolean dragging() { return drag; }

    void setDragging() { drag = true; }

    void clearDrag() { drag = false; update(); drawSelf(); }

    void drawSelf() {
        pushStyle();
            stroke(drag ? glowBG : controlsBG);
            strokeWeight(gripSize+4);
            line(hMin, yOff, hMax, yOff);
        popStyle();
        pushStyle();
            strokeWeight(2);
            stroke(255);
            fill(drag ? gripGlow : gripColor);
            ellipse(hPos, yOff, gripSize, gripSize);
        popStyle();
    }
    void drag() {
        hPos = constrain(mouseX, hMin, hMax);
        update();
        drawSelf();
    }
}


