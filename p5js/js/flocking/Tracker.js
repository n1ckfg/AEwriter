"use strict";

class Tracker {

    constructor() {
        this.AEpath = []; //PVectors
        this.p = createVector(0,0,0);
        this.s = createVector(8,8);
    }

    update() {
        if (useLeap) {
            try {
                float posX = map(pos[0], -250, 250, 0, 640);
                float posY = map(pos[1], 550, 30, 0, 360);
                float posZ = map(pos[2], 200,  -300, -200, 200);
                p = new PVector(posX, posY, posZ);
            } catch(Exception e) { }
        } else {
            if (mouseX != pmouseX && mouseY != pmouseY) {
                p.x = mouseX;
                p.y = mouseY;
                //p.z = 0;
            }
        }
        if (record) {
            PVector v1 = new PVector((p.x / sW) * dW, (p.y / sH) * dH, (p.z / sD) * sD);
            AEpath.add(v1);
        }
    }
    
    draw() {
        pushMatrix();
        ellipseMode(CENTER);
        if (record) {
            fill(200 + random(55), 30, 30, 200);
        } else {
            fill(3, 220, 30, 200);
        }
        noStroke();
        translate(p.x, p.y, p.z);
        if (record) {
            float q = 1 + random(0.5);
            ellipse(0, 0, q * s.x, q * s.y);
        } else {
            ellipse(0, 0, s.x, s.y);
        }
        popMatrix();
    }
    
    run(){
        update();
        draw();
    }

}
