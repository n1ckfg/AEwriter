String mayaFileName = "mayaScript";
String mayaFilePath = scriptsFilePath;
String mayaFileType = "py";

void mayaKeysMain() {
  mayaKeysBegin();
  for (int i=0;i<numParticles;i++) {
    dataMaya.add("polyCube()" + "\r");
    for (int j=0;j<counter;j++) {
      mayaKeyPos(i,j);
    }
}
    mayaKeysEnd();
}

void mayaKeyPos(int spriteNum, int frameNum){
  
     // smoothing algorithm by Golan Levin

   PVector lower, upper, centerNum;

     centerNum = (PVector) particle[spriteNum].AEpath.get(frameNum);

     if(applySmoothing && frameNum>smoothNum && frameNum<counter-smoothNum){
       lower = (PVector) particle[spriteNum].AEpath.get(frameNum-smoothNum);
       upper = (PVector) particle[spriteNum].AEpath.get(frameNum+smoothNum);
       centerNum.x = (lower.x + weight*centerNum.x + upper.x)*scaleNum;
       centerNum.y = (lower.y + weight*centerNum.y + upper.y)*scaleNum;
       centerNum.z = (lower.z + weight*centerNum.z + upper.z)*scaleNum;
     }
     
     if(frameNum%smoothNum==0||frameNum==0||frameNum==counter-1){
       dataMaya.add("currentTime("+frameNum+")"+"\r");
       dataMaya.add("move(" + (centerNum.x/100) + ", " + (centerNum.y/100) + "," + (centerNum.z/100) + ")" + "\r");
       dataMaya.add("setKeyframe()" + "\r");
     }
}

void mayaKeyRot(int spriteNum, int frameNum){
   /*

   float lower, upper, centerNum;

     centerNum = particle[spriteNum].AErot[frameNum];

     if(applySmoothing && frameNum>smoothNum && frameNum<counter-smoothNum){
       lower = particle[spriteNum].AErot[frameNum-smoothNum];
       upper = particle[spriteNum].AErot[frameNum+smoothNum];
       centerNum = (lower + weight*centerNum + upper)*scaleNum;
     }
     
     if(frameNum%smoothNum==0||frameNum==0||frameNum==counter-1){
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
  dataMaya.add("playbackOptions(minTime=\"0\", maxTime=\"" + counter + "\")" + "\r");
  dataMaya.add("#grav = gravity()" + "\r");  
  dataMaya.add("\r");  
}

void mayaKeysEnd() {
  dataMaya.add("#floor = polyPlane(w=30,h=30)" + "\r");
  dataMaya.add("#rigidBody(passive=True)" + "\r");
  dataMaya.add("#move(0,0,0)" + "\r");
  dataMaya.endSave(mayaFilePath + "/" + mayaFileName + "." + mayaFileType);
}



