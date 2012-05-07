void AEdataPosWrite() {
  for (int i=0;i<numParticles;i++) {
    data.add("\t" + "var solid = myComp.layers.addSolid([1.0, 1.0, 0], \"my square\", 50, 50, 1);" + "\r");
    data.add("\t" + "solid.motionBlur = true;" + "\r");
    data.add("\t" + "var myEffect = solid.property(\"Effects\").addProperty(\"Fast Blur\")(\"Blurriness\").setValue(61);");
    data.add("\r");
    data.add("\t" + "var p = solid.property(\"position\");" + "\r");
    data.add("\r");

    for (int j=0;j<counterMax;j++) {
      data.add("\t\t" + "p.setValueAtTime(" + ((float(j)/float(counterMax)) * (float(counterMax)/float(fps))) + ", [ " + particle[i].path[j].x + ", " + particle[i].path[j].y + "]);" + "\r");
    }
    
  }
}

