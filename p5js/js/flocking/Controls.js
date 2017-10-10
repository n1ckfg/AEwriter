"use strict";

function keyPressed(){
  if(key=='l' || key=='L') useLeap = !useLeap;

  if(key==' '){
  	if(!record & firstRun){
  		obj1 = "";
  		obj2 = "";
  	}
    record = !record;
    firstRun=false;
  }
}

function mousePressed() {
  //
}
