"use strict";

//**************************
var fps = 24;
//var durationTimeInSec = 20;
var numParticles = 100;
var motionBlur = true;
var applyEffects = false;
var applySmoothing = true;
var record, firstRun;
var borders = false;
var useLeap = false;
//var useOsc = true;
var c = createVector(20,20,20); //collision range
var smoothNum = 6; //smoothing
var weight = 18;
var scaleNum  = 1.0 / (weight + 2);
//---
var tracePath = true;
var scriptsFilePath = "scripts";
//String obj1 = ""; //PLACEHOLDER FOR PJS
//float[] pos = {0,0,0}; //PLACEHOLDER FOR PJS
//**************************

//this sketch
var sW = 640;
var sH = 360;
var sD = 400;

//destination After Effects comp
var dW = 1920;
var dH = 1080;
var dD = 1000;

var counter;
//var counterMax = int(durationTimeInSec * fps);
var particle = new Boid[numParticles];
var traceColor = color(255, 0, 0, 250);
var writeAE = true;
var writeMaya = true;

var tracker;

function writeAllKeys() {
  if (writeAE) AEkeysMain();  // After Effects, JavaScript
  if (writeMaya) mayaKeysMain();  // Maya, Python
}

function initSettings() {
  //Settings settings = new Settings("settings.txt");
  //counterMax = int(durationTimeInSec * fps);
  counter=0;
  record = false;
  firstRun = true;
  for (var i=0; i<numParticles; i++) {
    particle[i].AEpath = new ArrayList();
  }
  //if(useOsc) oscSetup();
}

function setup() {
  particle = new Boid[numParticles];
  tracker = new Tracker();
  var canvas = createCanvas(sW, sH, WEBGL);
  canvas.parent("pjs");
  frameRate(fps);
  noCursor();
  for (var i=0; i<numParticles; i++) {
    particle[i] = new Boid(createVector(random(sW), random(sH), random(sD)), 10.0, 0.5); //orig 4.0, 0.1
  }
  initSettings();
}

function draw() {
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
    for (var j=0;j<tracker.AEpath.size();j++) {
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
  for (var i=0;i<numParticles;i++) {
    //if(i>0 && hitDetect3D(particle[i].loc,c,particle[i-1].loc,c)){
    if(i>0 && hitDetect(particle[i].loc.x,particle[i].loc.y,c.x,c.y,particle[i-1].loc.x,particle[i-1].loc.y,c.x,c.y)){
      particle[i].t = new PVector(random(sW), random(sH), random(sD));
    }else{
      particle[i].t = tracker.p;
    }
    particle[i].run();
  }
  tracker.draw();
  if (record) {
    counter++;
    println("frames: " + counter + "   seconds: " + (counter/fps));
  } else if (!record && !firstRun) {
    writeAllKeys();
    initSettings();
  }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function hitDetect(var x1, var y1, var w1, var h1, var x2, var y2, var w2, var h2) {
  w1 /= 2;
  h1 /= 2;
  w2 /= 2;
  h2 /= 2; 
  if (x1 + w1 >= x2 - w2 && x1 - w1 <= x2 + w2 && y1 + h1 >= y2 - h2 && y1 - h1 <= y2 + h2) {
    return true;
  } else {
    return false;
  }
}

    //3D Hit Detect.  Assumes center.  xyz, whd of obj1ect 1, xyz, whd of obj1ect 2.
function hitDetect3D(PVector p1, PVector s1, PVector p2, PVector s2) {
    s1.x /= 2;
    s1.y /= 2;
    s1.z /= 2;
    s2.x /= 2;
    s2.y /= 2; 
    s2.z /= 2; 
    if (  p1.x + s1.x >= p2.x - s2.x && 
          p1.x - s1.x <= p2.x + s2.x && 
          p1.y + s1.y >= p2.y - s2.y && 
          p1.y - s1.y <= p2.y + s2.y &&
          p1.z + s1.z >= p2.z - s2.z && 
          p1.z - s1.z <= p2.z + s2.z
      ) {
      return true;
    } else {
      return false;
    }
}

