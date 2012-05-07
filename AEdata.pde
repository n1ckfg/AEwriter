void AEdataInit() {
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

void AEdataSave() {
  data.add("\r");
  data.add("\t" + "app.endUndoGroup();" + "\r");
  data.add("}  //end script" + "\r");
  data.endSave("data/"+ aeFilePath + "/" + aeFileName + "." + aeFileType);
}
