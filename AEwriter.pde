import processing.opengl.*;

Data data;
int counter=0;
int counterMax = 15 * 24;

//this sketch
int sW = 640;
int sH = 360;

//destination After Effects comp
int dW = 1920;
int dH = 1080;

int fps = 24;

String aeFileName = "AEscript";
String aeFilePath = "";
String aeFileType = "jsx";

int numParticles = 10;
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

