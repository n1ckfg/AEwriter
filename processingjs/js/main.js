//~~~   1.  LEAP   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
var fingers = {};
var spheres = {};
var pos = [ 0,0,0 ];

Leap.loop(function(frame) {
  //try{  
    var fingerIds = {};
    var handIds = {};

    //TRACK POINTABLES
    /*
    for (var pointableId = 0, pointableCount = frame.pointables.length; pointableId != pointableCount; pointableId++) {
      var pointable = frame.pointables[pointableId];
       pos = [ pointable.tipPosition[0], pointable.tipPosition[1], pointable.tipPosition[2] ];
       //pos = [ pointable.tipPosition[0], pointable.tipPosition[1], -pointable.tipPosition[2] ];
      //pos = [ pointable.tipPosition[0], pointable.tipPosition[1] ];
      console.log(pos);
      //alert(""+pos);
      //var finger = fingers[pointable.id]
      //var origin = new THREE.Vector3(pointable.tipPosition[0], pointable.tipPosition[1], -pointable.tipPosition[2])
      //var direction = new THREE.Vector3(pointable.direction[0], pointable.direction[1], -pointable.direction[2]);
    }
    */
    //TRACK HANDS
    if (frame.hands === undefined ) { 
      var handsLength = 0 
    } else {
      var handsLength = frame.hands.length;
    }

    for (var handId = 0, handCount = handsLength; handId != handCount; handId++) {
      var hand = frame.hands[handId];
      var posX = (hand.palmPosition[0]);
      var posY = (hand.palmPosition[1]);
      var posZ = (hand.palmPosition[2]);
      //var posX = (hand.palmPosition[0]*3);
      //var posY = (hand.palmPosition[2]*3)-200;
      //var posZ = (hand.palmPosition[1]*3)-400;
      //var rotX = (hand.rotation[1][2]*90);
      //var rotY = (hand.rotation[1][1]*90);
      //var rotZ = (hand.rotation[1][0]*90);
      pos = [ posX, posY, posZ ];
      console.log(pos);
    }
  //}catch(e){}
});

//~~~   2.  UI   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   

var pjs,button1,button2;
var obj1 = "You haven't recorded anything yet.";
var obj2 = "You haven't recorded anything yet.";

function setup(){
  pjs = Processing.getInstanceById("pjs");
  document.getElementById("pjs").focus();
  button1 = document.getElementById("button1");
  button1.onclick = saveText1;
  button2 = document.getElementById("button2");
  button2.onclick = saveText2;
}

function saveText1() {
  var uriContent = "data:text/plain;charset=utf-8," + encodeURIComponent(obj1);
  window.open(uriContent);
}

function saveText2() {
  var uriContent = "data:text/plain;charset=utf-8," + encodeURIComponent(obj2);
  window.open(uriContent);
}

window.onload = setup;
