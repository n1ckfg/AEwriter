void mayaKeysMain() {
  mayaKeysBegin();
  for (int i=0;i<numParticles;i++) {
    obj2 += "polyCube()" + "\r";
    for (int j=0;j<counter;j++) {
      mayaKeyPos(i,j);
    }
    obj2 += "\r"; 
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
       obj2 += "currentTime("+frameNum+")"  +"\r";
       obj2 += "move(" + (centerNum.x/100) + ", " + (centerNum.y/100) + "," + (centerNum.z/100) + ")" + "\r";
       obj2 += "setKeyframe()" + "\r";
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
      obj2 += "\t\t" + "r.setValueAtTime(" + AEkeyTime(frameNum) + ", " + centerNum +");" + "\r";
     }
     */
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void mayaKeysBegin() {
  //dataMaya = new Data();
  //dataMaya.beginSave();
  obj2 = "";
  obj2 += "# * * * Python for Maya ... save with extension .PY * * *" + "\r";
  obj2 += "\r";  
  obj2 += "from maya.cmds import *" + "\r";
  obj2 += "from random import uniform as rnd" + "\r";
  obj2 += "#select(all=True)" + "\r";
  obj2 += "#delete()" + "\r";
  obj2 += "playbackOptions(minTime=\"0\", maxTime=\"" + counter + "\")" + "\r";
  obj2 += "#grav = gravity()" + "\r";  
  obj2 += "\r";  
}

void mayaKeysEnd() {
  obj2 += "#floor = polyPlane(w=30,h=30)" + "\r";
  obj2 += "#rigidBody(passive=True)" + "\r";
  obj2 += "#move(0,0,0)" + "\r";
  //dataMaya.endSave(mayaFilePath + "/" + mayaFileName + "." + mayaFileType);
}



