PVector p;
Data data;
int counter=0;
int counterMax = 100;
//this sketch
int sW = 640;
int sH = 360;

//destination comp
int dW = 1920;
int dH = 1080;

int fps = 24;

String aeFileName = "AEdata";
String aeFilePath = "";
String aeFileType = "txt";

void setup() {
  size(sW, sH);
  frameRate(fps);
  p = new PVector(0, 0);
  AEdataInit();
  AEdataPosInit();
}

void draw() {
  if (counter<counterMax) {
    background(0);
    strokeWeight(20);
    stroke(255);
    p.x=random(width);
    p.y=random(height);
    point(p.x, p.y);
    
    AEdataPosWrite();
    counter++;
    println(counter + " / " + counterMax);
  } else {
    AEdataSave();   
    exit();
  }
}

