PVector p, v;
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
  v = new PVector(10, 10);
  AEdataInit();
  AEdataPosInit();
}

void draw() {
  if (counter<counterMax) {
    background(0);
    strokeWeight(20);
    stroke(255);
    p.add(v);
    if(p.x<0||p.x>sW){
    v.x *= -1;
    };
    if(p.y<0||p.y>sH){
    v.y *= -1;
    };
    point(p.x, p.y);
    
    AEdataPosWrite();
    counter++;
    println(counter + " / " + counterMax);
  } else {
    AEdataSave();   
    exit();
  }
}

