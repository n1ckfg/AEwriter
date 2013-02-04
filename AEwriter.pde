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
boolean borders = false;
boolean useOsc = true;
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
int sD = 400;

//destination After Effects comp
int dW = 1920;
int dH = 1080;
int dD = 1000;

Data dataAE, dataMaya;
int counter=0;
//int counterMax = int(durationTimeInSec * fps);
Boid[] particle = new Boid[numParticles];
color traceColor = color(255, 0, 0, 250);
boolean writeAE = true;
boolean writeMaya = true;

Tracker tracker;

void writeAllKeys() {
  if (writeAE) AEkeysMain();  // After Effects, JavaScript
  if (writeMaya) mayaKeysMain();  // Maya, Python
}

void initSettings() {
  Settings settings = new Settings("settings.txt");
  //counterMax = int(durationTimeInSec * fps);
  particle = new Boid[numParticles];
  tracker = new Tracker();
  if(useOsc) oscSetup();
}

void setup() {
  initSettings();
  size(sW, sH, OPENGL);
  frameRate(fps);
  noCursor();
  for (int i=0;i<numParticles;i++) {
    particle[i] = new Boid(new PVector(random(sW), random(sH)), 10.0, 0.5); //orig 4.0, 0.1
  }
}

void draw() {
  if (!record) {
    background(0);
  }
  else {
    background(50, 0, 0);
  }
  strokeWeight(100);
  //~~
  tracker.update();
  //broken; not sure why?
  /*
  if (tracePath) {
    strokeWeight(4);
    stroke(traceColor);
    noFill();
    for (int j=0;j<tracker.AEpath.size();j++) {
      if (j>0) {
        PVector tracePoint1 = (PVector) tracker.AEpath.get(j);
        PVector tracePoint2 = (PVector) tracker.AEpath.get(j-1);
        if (tracePoint1.x!=0 && tracePoint1.y!=0 && tracePoint2.x!=0 && tracePoint2.y!=0) {
          beginShape();
          vertex(tracePoint1.x,tracePoint1.y,tracePoint1.z);//,tracePoint1.z);
          vertex(tracePoint2.x,tracePoint2.y,tracePoint2.z);//,tracePoint2.z);
          endShape();
        }
      }
    }
  }
  */
  for (int i=0;i<numParticles;i++) {
    particle[i].run();
  }
  tracker.draw();
  if (record) {
    counter++;
    println("frames: " + counter + "   seconds: " + (counter/fps));
  }
  else if (!record && !firstRun) {
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
  if (x1 + w1 >= x2 - w2 && x1 - w1 <= x2 + w2 && y1 + h1 >= y2 - h2 && y1 - h1 <= y2 + h2) {
    return true;
  } 
  else {
    return false;
  }
}

