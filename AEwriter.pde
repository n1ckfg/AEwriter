import processing.opengl.*;

//**************************
int fps = 24;
//float durationTimeInSec = 20;
int numParticles = 100;
boolean motionBlur = true;
boolean applyEffects = false;
boolean applySmoothing = true;
boolean record = false;
boolean firstRun = true;
//smoothing
int smoothNum = 6;
float weight = 18;
float scaleNum  = 1.0 / (weight + 2);
//---
boolean tracePath = true;
String scriptsFilePath = "scripts";
//**************************

//this sketch
int sW = 640;
int sH = 360;

//destination After Effects comp
int dW = 1920;
int dH = 1080;

Data dataAE, dataMaya;
int counter=0;
//int counterMax = int(durationTimeInSec * fps);
Boid[] particle = new Boid[numParticles];
ArrayList traceController;
color traceColor = color(255,0,0,50);
boolean writeAE = true;
boolean writeMaya = true;

void writeAllKeys(){
    if(writeAE) AEkeysMain();  // After Effects, JavaScript
    if(writeMaya) mayaKeysMain();  // Maya, Python
}

void initSettings(){
  Settings settings = new Settings("settings.txt");
  //counterMax = int(durationTimeInSec * fps);
  particle = new Boid[numParticles];
}

void setup() {
  initSettings();
  size(sW, sH, OPENGL);
  frameRate(fps);
  traceController = new ArrayList();
  for (int i=0;i<numParticles;i++) {
    particle[i] = new Boid(new PVector(random(sW), random(sH)), 10.0, 0.5); //orig 4.0, 0.1
  }
}

void draw() {
  if(!record){
    background(0);
  }else{
    background(100,0,0);
  }
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

  if (record) {
    counter++;
    println("frames: " + counter + "   seconds: " + (counter/fps));
  }else if (!record && !firstRun){
    writeAllKeys();
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
