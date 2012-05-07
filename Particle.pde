class Particle {
  PVector[] path = new PVector[counterMax];
  PVector p, v, a;
  float vMax = 10;

  Particle() {
    p = new PVector(random(sW),random(sH));
    v = new PVector(vMax, vMax);
    a = new PVector(random(0.1),random(0.1));
  }

  void update() {
    if (mousePressed) {
      p.x += (mouseX - p.x)/vMax;
      p.y += (mouseY - p.y)/vMax;
    } 
    else {
      if (p.x<0||p.x>sW) {
        v.x *= -1;
      }
      if (p.y<0||p.y>sH) {
        v.y *= -1;
      }
      v.add(a);
      p.add(v);
    }
    if(counter<counterMax){
      path[counter] = new PVector((p.x/sW)*dW,(p.y/sH)*dH);
    }
    drawParticle();
  }

  void drawParticle() {
    strokeWeight(20);
    stroke(255);
    point(p.x, p.y);
  }
}

