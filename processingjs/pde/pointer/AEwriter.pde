import processing.opengl.*;

boolean record = false;

//comment this out for JS
//String obj1 = "";

int numParticles = 1;
Particle[] particle = new Particle[numParticles];
boolean motionBlur = true;
boolean applyEffects = false;
boolean applySmoothing = true;

//this sketch
int sW = 640;
int sH = 360;
int sD = 400;

//destination After Effects comp
int dW = 1920;
int dH = 1080;
int dD = 1000;

int fps = 24;
int counter = 0;
boolean applySmoothing = true;
boolean useLeap = false;
int smoothNum = 6; //smoothing
float weight = 18;
float scaleNum  = 1.0 / (weight + 2);

void setup() {
  size(sW, sH, OPENGL);
  frameRate(fps);
  noCursor();
  for (int i=0;i<particle.length;i++) {
    particle[i] = new Particle();
  }
}

void draw() {
  if (record) {
    background(50, 0, 0);
    counter++;
  }
  else {
    background(0);
  }
  for (int i=0;i<particle.length;i++) {
    particle[i].run();
  }
}




