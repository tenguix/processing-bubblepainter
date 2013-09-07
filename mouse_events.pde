int focusedArea() {
    if(focused) {
        for(int i = 0; i < xHints.length; i++) {
            if(mouseX < xHints[i]) return i;
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
                if(sliders[n].hovering())         sliders[n].setDragging();
                else if(sliders[n].dragging())    sliders[n].drag();
                break;
            case 3:
                frameRate(hm.get("Rate"));
                pushStyle();
                    stroke(
                        hm.get("Hue"),    hm.get("Sat"),
                        hm.get("Bright"), hm.get("Alpha")
                    );
                    float r = hm.get("Radius")
                              - sqrt(dist(pmouseX,pmouseY,mouseX,mouseY));
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
