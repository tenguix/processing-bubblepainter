import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
public void setup() {
    size(400, 255);
    frameRate(8);
    background(64);
    // noLoop();
    colorMode(HSB);
}
public float[] spectrum(float[] args, int count){
    float min = args[0];
    float max = args[1];
    float[] ret = new float[count];
    switch(args.length){
        case 4:
            min = lerp(args[0],args[1], args[2]);
            max = lerp(args[0],args[1], args[3]);
        case 2:
            for(int i = 0; i < count; i++){
                ret[i] = lerp(min, max, (float) i/(count-1));
            }
        default:
            return ret;
    }
}
public void drawSingle(int x, int y, int len, int c){
    pushStyle();
        strokeWeight(1);
        stroke(c);
        line(x, y-len, x, y+len);
    popStyle();
}
/* here be dragons. */
public void draw() {
    background(64);
    int x1, x2, yOff, y, wid;
    x1 = 20;
    x2 = width-20;
    wid = x2 - x1;
    y = yOff = height/5;
    float[] ary = { 300, 192, 192, 255 };
    for(int i = 0; i < 4; i++){
        float offset = abs(mouseY - y);
        float[] args = { 0 + offset, 255 - offset };
        float[] spec = spectrum(args, wid);
        if(offset < yOff/2){
            int moff = int(yOff/offset);
            for(int j = 0; j < spec.length; j++){
                float[] a = ary;
                a[i] = spec[j];
                color c = color(a[0],a[1],a[2],a[3]);
                drawSingle(
                    j + x1,
                    y,
                    constrain(int(random(moff))-1, 0, 20),
                    c
                );
            }
        }
    y += yOff;
    }
}
