PVector p, v;
float vMax = 10;

Data data;
int counter=0;
int counterMax = 300;

//this sketch
int sW = 640;
int sH = 360;

//destination After Effects comp
int dW = 1920;
int dH = 1080;

int fps = 24;

String aeFileName = "AEdata";
String aeFilePath = "";
String aeFileType = "txt";



void setup() {
  size(sW, sH);
  frameRate(fps);
  p = new PVector(sW/2, sH/2);
  v = new PVector(vMax, vMax);
  AEdataInit();
  AEdataPosInit();
}

void draw() {
  background(0);
  strokeWeight(20);
  stroke(255);

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
    p.add(v);
  }

  point(p.x, p.y);

  if (counter<counterMax) {
    AEdataPosWrite();
    counter++;
    println(counter + " / " + counterMax);
  } 
  else {
    AEdataSave();   
    exit();
  }
}

