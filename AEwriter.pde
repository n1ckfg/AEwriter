import processing.opengl.*;

//**************************
int fps = 24;
float durationFrames = 10 * fps;
int numParticles = 100;
boolean motionBlur = true;
boolean applyEffects = false;
boolean applySmoothing = true;
int smoothNum = 6;
boolean tracePath = true;
//**************************

//this sketch
int sW = 640;
int sH = 360;

//destination After Effects comp
int dW = 1920;
int dH = 1080;

Data dataAE, dataMaya;
int counter=0;
int counterMax = int(durationFrames);
Boid[] particle = new Boid[numParticles];
ArrayList traceController;
color traceColor = color(255,0,0,50);

void setup() {
  size(sW, sH, OPENGL);
  frameRate(fps);
  traceController = new ArrayList();
  for (int i=0;i<numParticles;i++) {
    particle[i] = new Boid(new PVector(random(sW), random(sH)), 10.0, 0.5); //orig 4.0, 0.1
  }
  AEkeysBegin();
  mayaKeysBegin();
}

void draw() {
  background(0);
  if(tracePath){
  traceController.add(new PVector(mouseX, mouseY));
  strokeWeight(2);
  stroke(traceColor);
  for (int j=0;j<traceController.size();j++) {
    if (j>0) {
      PVector tracePoint1 = (PVector) traceController.get(j);
      PVector tracePoint2 = (PVector) traceController.get(j-1);
      if (tracePoint1.x!=0&&tracePoint1.y!=0&&tracePoint2.x!=0&&tracePoint2.y!=0) {
        line(tracePoint1.x, tracePoint1.y, tracePoint2.x, tracePoint2.y);
      }
    }
  }
  }
  for (int i=0;i<numParticles;i++) {
    particle[i].run();
  }

  if (counter<counterMax) {
    counter++;
    println(counter + " / " + counterMax);
  } 
  else {
    AEkeysMain();
    AEkeysEnd();   
    mayaKeysMain();
    mayaKeysEnd();
    exit();
  }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

boolean hitDetect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  w1 /= 2;
  h1 /= 2;
  w2 /= 2;
  h2 /= 2; 
  if(x1 + w1 >= x2 - w2 && x1 - w1 <= x2 + w2 && y1 + h1 >= y2 - h2 && y1 - h1 <= y2 + h2) {
    return true;
  } 
  else {
    return false;
  }
}
