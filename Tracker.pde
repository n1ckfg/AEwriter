class Tracker{
  ArrayList AEpath = new ArrayList(); //PVectors
  PVector p,s;
  
  Tracker(){
    p = new PVector(0,0,0);
    s = new PVector(8,8);
  }

  void update(){
    //if(!useOsc){
    if(mouseX != pmouseX && mouseY != pmouseY){
      p.x = mouseX;
      p.y = mouseY;
      //p.z = 0;
    }
    if (record) {
      PVector v1 = new PVector((p.x/sW)*dW, (p.y/sH)*dH, (p.z/sD)*sD);
      AEpath.add(v1);
    }
  }
  
  void draw(){
    pushMatrix();
    ellipseMode(CENTER);
    if(record){
      fill(200 + random(55),30,30,200);
    }else{
      fill(3,220,30,200);
    }
    noStroke();
    translate(p.x,p.y,p.z);
    if(record){
      float q = 1 + random(0.5);
      ellipse(0,0,q*s.x,q*s.y);
    }else{
      ellipse(0,0,s.x,s.y);
    }
    popMatrix();
  }
  
  void run(){
    update();
    draw();
  }
}
