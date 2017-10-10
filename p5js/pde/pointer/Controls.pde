void keyPressed(){
  if(key=='l' || key=='L') useLeap = !useLeap;
  if(key==' '){
    if(record){
    AEkeysMain();
    mayaKeysMain();
    for (int i=0;i<particle.length;i++) {
      particle[i].AEpath = new ArrayList();
    }
    counter=0;
  }else{
    obj1 = "";
    obj2 = "";
  }
  record = !record;
  }
}

void mousePressed() {
  //
}