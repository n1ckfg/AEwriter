// Seek_Arrive
// Daniel Shiffman <http://www.shiffman.net>

// The "Boid" class

// Created 2 May 2005

class Boid {
  //this is needed to record AE keyframe data
  ArrayList AEpath = new ArrayList(); //PVectors
  ArrayList AErot = new ArrayList(); //floats

  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float theta; //rotation

  Boid(PVector l, float ms, float mf) {
    acc = new PVector(0, 0, 0);
    vel = new PVector(0, 0, 0);
    loc = l.get();
    r = 3.0;
    maxspeed = ms;
    maxforce = mf;
  }

  void run() {
    update();
    draw();
  }

  // Method to update location
  void update() {
    seek(tracker.p);
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
      PVector v1 = new PVector((loc.x/sW)*dW, (loc.y/sH)*dH, (loc.z/sD)*dD);
      float v2 = degrees(theta);
      AEpath.add(v1);
      AErot.add(v2);
    }
  }

  void seek(PVector target) {
    acc.add(steer(target, false));
  }

  void arrive(PVector target) {
    acc.add(steer(target, true));
  }

  // A method that calculates a steering vector towards a target
  // Takes a second argument, if true, it slows down as it approaches the target
  PVector steer(PVector target, boolean slowdown) {
    PVector steer;  // The steering vector
    PVector desired = PVector.sub(target, loc);  // A vector pointing from the location to the target
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
      steer.limit(maxforce);  // Limit to maximum steering force
    } 
    else {
      steer = new PVector(0, 0, 0);
    }
    return steer;
  }

  void draw() {
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
  }

  // Wraparound
  void bordersHandler() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }
}

