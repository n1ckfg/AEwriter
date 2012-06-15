String mayaFileName = "mayaScript";
String mayaFilePath = masterFilePath;
String mayaFileType = "py";

void mayaKeysMain() {
  mayaKeysBegin();
  for (int i=0;i<numParticles;i++) {
    dataMaya.add("polyCube()" + "\r");
    for (int j=0;j<counterMax;j++) {
      mayaKeyPos(i,j);
    }
}
    mayaKeysEnd();
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
       dataMaya.add("currentTime("+frameNum+")"+"\r");
       dataMaya.add("move(" + (centerNum.x/100) + ", " + (centerNum.y/100) + "," + 0 + ")" + "\r");
       dataMaya.add("setKeyframe()" + "\r");
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
      dataMaya.add("\t\t" + "r.setValueAtTime(" + AEkeyTime(frameNum) + ", " + centerNum +");" + "\r");
     }
     */
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void mayaKeysBegin() {
  dataMaya = new Data();
  dataMaya.beginSave();
  dataMaya.add("from maya.cmds import *" + "\r");
  dataMaya.add("from random import uniform as rnd" + "\r");
  dataMaya.add("#select(all=True)" + "\r");
  dataMaya.add("#delete()" + "\r");
  dataMaya.add("playbackOptions(minTime=\"0\", maxTime=\"" + counterMax + "\")" + "\r");
  dataMaya.add("#grav = gravity()" + "\r");  
  dataMaya.add("\r");  
}

void mayaKeysEnd() {
  dataMaya.add("#floor = polyPlane(w=30,h=30)" + "\r");
  dataMaya.add("#rigidBody(passive=True)" + "\r");
  dataMaya.add("#move(0,0,0)" + "\r");
  dataMaya.endSave(mayaFilePath + "/" + mayaFileName + "." + mayaFileType);
}



