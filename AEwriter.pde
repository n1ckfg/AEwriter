import processing.opengl.*;

//**************************
int fps = 24;
float durationFrames = 5 * fps;
int numParticles = 10;
boolean motionBlur = true;
boolean applyEffects = false;
boolean applySmoothing = false; //this doesn't really work right now
float smoothNum = 250;
//**************************

//this sketch
int sW = 640;
int sH = 360;

//destination After Effects comp
int dW = 1920;
int dH = 1080;

String aeFileName = "AEscript";
String aeFilePath = "";
String aeFileType = "jsx";

Data data;
int counter=0;
int counterMax = int(durationFrames);
Boid[] particle = new Boid[numParticles];

void setup() {
  size(sW, sH, OPENGL);
  frameRate(fps);
  for(int i=0;i<numParticles;i++){
    particle[i] = new Boid(new PVector(random(sW),random(sH)),10.0,0.5); //orig 4.0, 0.1
  }
  AEkeysBegin();
}

void draw() {
  background(0);

  for(int i=0;i<numParticles;i++){
    particle[i].run();
  }

  if (counter<counterMax) {
    counter++;
    println(counter + " / " + counterMax);
  } 
  else {
    AEkeysMain();
    AEkeysEnd();   
    exit();
  }
}

