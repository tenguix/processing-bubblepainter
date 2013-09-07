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
        if(drag) return false;
        else     return dist(mouseX, mouseY, hPos, yOff) < gripSize;
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
