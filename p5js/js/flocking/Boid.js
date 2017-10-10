"use strict";

// Seek_Arrive
// Daniel Shiffman <http://www.shiffman.net>

// The "Boid" class

// Created 2 May 2005

class Boid {

    constructor(PVector l, float ms, float mf) {
        //this is needed to record AE keyframe data
        this.AEpath = []; //PVectors
        this.AErot = []; //floats
        this.theta = 0; //rotation ...unused?
        this.acc = new PVector(0, 0, 0);
        this.vel = new PVector(0, 0, 0);
        this.t = new PVector(random(sW), random(sH), random(sD));
        this.loc = l.get();
        this.r = 3.0;
        this.maxspeed = ms;
        this.maxforce = mf;
    }

    run() {
        this.update();
        this.draw();
    }

    // Method to update location
    update() {
        seek(t);
        //~~~~~~~~~~~~~~~~~
        // Update velocity
        vel.add(acc);
        // Limit speed
        vel.limit(maxspeed);
        loc.add(vel);
        // Reset accelertion to 0 each cycle
        acc.mult(0);
        //~~~~~~~~~~~~~~~~~
        if(borders) bordersHandler();
        //~~~~~~~~~~~~~~~~~
        //this is needed to record AE keyframe data
        if (record) {
            PVector v1 = new PVector((loc.x / sW) * dW, (loc.y / sH) * dH, (loc.z / sD) * dD);
            float v2 = degrees(theta);
            AEpath.add(v1);
            AErot.add(v2);
        }
    }

    seek(PVector target) {
        acc.add(steer(target, false));
    }

    arrive(PVector target) {
        acc.add(steer(target, true));
    }

    // A method that calculates a steering vector towards a target
    // Takes a second argument, if true, it slows down as it approaches the target
    steer(PVector target, boolean slowdown) {
        PVector steer;    // The steering vector
        PVector desired = PVector.sub(target, loc);    // A vector pointing from the location to the target
        float d = desired.mag(); // Distance from the target is the magnitude of the vector
        // If the distance is greater than 0, calc steering (otherwise return zero vector)
        if (d > 0) {
            // Normalize desired
            desired.normalize();
            // Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
            if ((slowdown) && (d < 100.0f)) desired.mult(maxspeed*(d/100.0f)); // This damping is somewhat arbitrary
            else desired.mult(maxspeed);
            // Steering = Desired minus Velocity
            steer = PVector.sub(desired, vel);
            steer.limit(maxforce);    // Limit to maximum steering force
        } 
        else {
            steer = new PVector(0, 0, 0);
        }
        return steer;
    }

    draw() {
        // Draw a triangle rotated in the direction of velocity
        theta = vel.heading2D() + radians(90);
        fill(175);
        strokeWeight(1);
        stroke(0);
        pushMatrix();
        translate(loc.x, loc.y, loc.z);
        rotate(theta);
        beginShape(TRIANGLES);
        vertex(0, -r*2);
        vertex(-r, r*2);
        vertex(r, r*2);
        endShape();
        popMatrix();
        //draws the target if it's not the global one
        /*
        if(t != tracker.p){
        pushMatrix();
        noStroke();
        fill(255,50);
        translate(t.x,t.y,t.z);
        ellipseMode(CENTER);
        ellipse(0,0,2,2);
        popMatrix();
        noFill();
        stroke(255,50);
        strokeWeight(1);
        line(t.x,t.y,t.z,loc.x,loc.y,loc.z);
        }
        */
    }

    // Wraparound
    bordersHandler() {
        if (loc.x < -r) loc.x = width + r;
        if (loc.y < -r) loc.y = height + r;
        if (loc.x > width + r) loc.x = -r;
        if (loc.y > height + r) loc.y = -r;
    }

}

