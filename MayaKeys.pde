String mayaFileName = "mayaScript";
String mayaFilePath = "";
String mayaFileType = "py";

void mayaKeysMain() {
  for (int i=0;i<numParticles;i++) {
    data.add("polyCube()" + "\r");
    
    tempZ = random(-10,10); //temporary fix until Boids work in 3D
    for (int j=0;j<counterMax;j++) {
      mayaKeyPos(i,j);
    }
}
}

void mayaKeyPos(int spriteNum, int frameNum){
  
     // smoothing algorithm by Golan Levin

   float weight = 18;
   float scaleNum  = 1.0 / (weight + 2);
   PVector lower, upper, centerNum;

     centerNum = new PVector(particle[spriteNum].AEpath[frameNum].x,particle[spriteNum].AEpath[frameNum].y);

     if(applySmoothing && frameNum>smoothNum && frameNum<counterMax-smoothNum){
       lower = new PVector(particle[spriteNum].AEpath[frameNum-smoothNum].x,particle[spriteNum].AEpath[frameNum-smoothNum].y);
       upper = new PVector(particle[spriteNum].AEpath[frameNum+smoothNum].x,particle[spriteNum].AEpath[frameNum+smoothNum].y);
       centerNum.x = (lower.x + weight*centerNum.x + upper.x)*scaleNum;
       centerNum.y = (lower.y + weight*centerNum.y + upper.y)*scaleNum;
     }
     
     if(frameNum%smoothNum==0||frameNum==0||frameNum==counterMax-1){
       data.add("currentTime("+frameNum+")"+"\r");
       data.add("move(" + (centerNum.x/100) + ", " + (centerNum.y/100) + "," + tempZ + ")" + "\r");
       data.add("setKeyframe()" + "\r");
     }
}

void mayaKeyRot(int spriteNum, int frameNum){
   /*
   float weight = 18;
   float scaleNum  = 1.0 / (weight + 2);
   float lower, upper, centerNum;

     centerNum = particle[spriteNum].AErot[frameNum];

     if(applySmoothing && frameNum>smoothNum && frameNum<counterMax-smoothNum){
       lower = particle[spriteNum].AErot[frameNum-smoothNum];
       upper = particle[spriteNum].AErot[frameNum+smoothNum];
       centerNum = (lower + weight*centerNum + upper)*scaleNum;
     }
     
     if(frameNum%smoothNum==0||frameNum==0||frameNum==counterMax-1){
      data.add("\t\t" + "r.setValueAtTime(" + AEkeyTime(frameNum) + ", " + centerNum +");" + "\r");
     }
     */
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void mayaKeysBegin() {
  data = new Data();
  data.beginSave();
  data.add("from maya.cmds import *" + "\r");
  data.add("from random import uniform as rnd" + "\r");
  data.add("#select(all=True)" + "\r");
  data.add("#delete()" + "\r");
  data.add("playbackOptions(minTime=\"0\", maxTime=\"" + counterMax + "\")" + "\r");
  data.add("#grav = gravity()" + "\r");  
  data.add("\r");  
}

void mayaKeysEnd() {
  data.add("#floor = polyPlane(w=30,h=30)" + "\r");
  data.add("#rigidBody(passive=True)" + "\r");
  data.add("#move(0,0,0)" + "\r");
  data.endSave("data/"+ mayaFilePath + "/" + mayaFileName + "." + mayaFileType);
}



