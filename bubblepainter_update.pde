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
    xHints[1] = controlsWidth + padding;
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

