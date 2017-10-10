void AEkeysMain() {
  AEkeysBegin();
  for (int i=0;i<numParticles;i++) {
    obj1 += "\t" + "var solid = myComp.layers.addSolid([1.0, 1.0, 0], \"my square\", 50, 50, 1);" + "\r";
    obj1 += "\t" + "solid.threeDLayer = true;" + "\r";
    if(motionBlur){
      obj1 += "\t" + "solid.motionBlur = true;" + "\r";
    }
    if(applyEffects){
      AEeffects();
    }
    obj1 += "\r";
    obj1 += "\t" + "var expr = \"var v=transform.position.velocity;\" + " + "\r";
    obj1 += "\t\t" + "\"var offset = 90;\" + " + "\r";
    obj1 += "\t\t" + "\"offset + radiansToDegrees(Math.atan2(v[1],v[0]));\"" + "\r";
    obj1 += "\t" + "solid.transform.zRotation.expression = expr;" + "\r";
    obj1 += "\t" + "var p = solid.property(\"position\");" + "\r";
    //obj1 += "\t" + "var r = solid.property(\"rotation\");" + "\r";
    obj1 += "\r";

    for (int j=0;j<counter;j++) {
      AEkeyPos(i,j);
      //AEkeyRot(i,j);
    }

    obj1 += "\r";
}
    AEkeysEnd();   
}

void AEkeysBegin() {
  //dataAE = new Data();
  //dataAE.beginSave();
  obj1 = "";
  obj1 += "// * * * JavaScript for After Effects ... save with extension .JSX * * *" + "\r";
  obj1 += "\r";  
  obj1 += "{  //start script" + "\r";
  obj1 += "\t" + "app.beginUndoGroup(\"foo\");" + "\r";
  obj1 += "\r";
  obj1 += "\t" + "// create project if necessary" + "\r";
  obj1 += "\t" + "var proj = app.project;" + "\r";
  obj1 += "\t" + "if(!proj) proj = app.newProject();" + "\r";
  obj1 += "\r";
  obj1 += "\t" + "// create new comp named 'my comp'" + "\r";
  obj1 += "\t" + "var compW = " + dW + "; // comp width" + "\r";
  obj1 += "\t" + "var compH = " + dH + "; // comp height" + "\r";
  obj1 += "\t" + "var compL = " + (counter/fps) + ";  // comp length (seconds)" + "\r";
  obj1 += "\t" + "var compRate = " + fps + "; // comp frame rate" + "\r";
  obj1 += "\t" + "var compBG = [0/255,0/255,0/255] // comp background color" + "\r";
  obj1 += "\t" + "var myItemCollection = app.project.items;" + "\r";
  obj1 += "\t" + "var myComp = myItemCollection.addComp('my comp',compW,compH,1,compL,compRate);" + "\r";
  obj1 += "\t" + "myComp.bgColor = compBG;" + "\r";
  obj1 += "\r";  
}
 
 void AEkeysEnd() {
 obj1 += "\r";
 obj1 += "\t" + "app.endUndoGroup();" + "\r";
 obj1 += "}  //end script" + "\r";
 }
 
 float AEkeyTime(int frameNum){
 return (float(frameNum)/float(counter)) * (float(counter)/float(fps));
 }
 
 void AEkeyPos(int spriteNum, int frameNum){
 // smoothing algorithm by Golan Levin
 
 PVector lower, upper, centerNum;
 
 p = (PVector) particle[spriteNum].AEpath.get(frameNum);
 centerNum = new PVector((p.x/sW)*dW, (p.y/sH)*dH, (p.z/sD)*dD);

 if(applySmoothing && frameNum>smoothNum && frameNum<counter-smoothNum){
 lower = (PVector) particle[spriteNum].AEpath.get(frameNum-smoothNum);
 upper = (PVector) particle[spriteNum].AEpath.get(frameNum+smoothNum);
 centerNum.x = (lower.x + weight*centerNum.x + upper.x)*scaleNum;
 centerNum.y = (lower.y + weight*centerNum.y + upper.y)*scaleNum;
 centerNum.z = (lower.z + weight*centerNum.z + upper.z)*scaleNum;
 }
 
 if(frameNum%smoothNum==0||frameNum==0||frameNum==counter-1){
 obj1 += "\t\t" + "p.setValueAtTime(" + AEkeyTime(frameNum) + ", [ " + centerNum.x + ", " + centerNum.y + ", " + centerNum.z + "]);" + "\r";
 }
 }
