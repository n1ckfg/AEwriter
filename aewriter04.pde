Data data;
int counter=0;
int counterMax = 5 * 24;

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
Particle[] particle = new Particle[numParticles];

void setup() {
  size(sW, sH);
  frameRate(fps);
  for(int i=0;i<numParticles;i++){
    particle[i] = new Particle();
  }
  AEdataInit();
}

void draw() {
  background(0);

  for(int i=0;i<numParticles;i++){
    particle[i].update();
  }

  if (counter<counterMax) {
    counter++;
    println(counter + " / " + counterMax);
  } 
  else {
    AEdataPosWrite();
    AEdataSave();   
    exit();
  }
}

