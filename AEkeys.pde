void AEkeysMain() {
  for (int i=0;i<numParticles;i++) {
    data.add("\t" + "var solid = myComp.layers.addSolid([1.0, 1.0, 0], \"my square\", 50, 50, 1);" + "\r");
    data.add("\t" + "solid.motionBlur = true;" + "\r");
    data.add("\t" + "var myEffect = solid.property(\"Effects\").addProperty(\"Fast Blur\")(\"Blurriness\").setValue(61);");
    data.add("\r");
    data.add("\t" + "var p = solid.property(\"position\");" + "\r");
    data.add("\t" + "var r = solid.property(\"rotation\");" + "\r");
    data.add("\r");

    for (int j=0;j<counterMax;j++) {
      data.add("\t\t" + "p.setValueAtTime(" + ((float(j)/float(counterMax)) * (float(counterMax)/float(fps))) + ", [ " + particle[i].AEpath[j].x + ", " + particle[i].AEpath[j].y + "]);" + "\r");
      data.add("\t\t" + "r.setValueAtTime(" + ((float(j)/float(counterMax)) * (float(counterMax)/float(fps))) + ", " + particle[i].AErot[j] +");" + "\r");
    }
    
  }
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void AEkeysBegin() {
  data = new Data();
  data.beginSave();
  data.add("{  //start script" + "\r");
  data.add("\t" + "app.beginUndoGroup(\"foo\");" + "\r");
  data.add("\r");
  data.add("\t" + "// create project if necessary" + "\r");
  data.add("\t" + "var proj = app.project;" + "\r");
  data.add("\t" + "if(!proj) proj = app.newProject();" + "\r");
  data.add("\r");
  data.add("\t" + "// create new comp named 'my comp'" + "\r");
  data.add("\t" + "var compW = " + dW + "; // comp width" + "\r");
  data.add("\t" + "var compH = " + dH + "; // comp height" + "\r");
  data.add("\t" + "var compL = " + (counterMax/fps) + ";  // comp length (seconds)" + "\r");
  data.add("\t" + "var compRate = " + fps + "; // comp frame rate" + "\r");
  data.add("\t" + "var compBG = [0/255,0/255,0/255] // comp background color" + "\r");
  data.add("\t" + "var myItemCollection = app.project.items;" + "\r");
  data.add("\t" + "var myComp = myItemCollection.addComp('my comp',compW,compH,1,compL,compRate);" + "\r");
  data.add("\t" + "myComp.bgColor = compBG;" + "\r");
  data.add("\r");  
}

void AEkeysEnd() {
  data.add("\r");
  data.add("\t" + "app.endUndoGroup();" + "\r");
  data.add("}  //end script" + "\r");
  data.endSave("data/"+ aeFilePath + "/" + aeFileName + "." + aeFileType);
}
