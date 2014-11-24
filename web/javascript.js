// javascript reference to our sketch
var pjs = undefined;
var bound = false;

// bind JS to the p5 sketch for two way communication
function bindJavaScript() {
  if(Processing) { pjs = Processing.getInstanceById("dsanim"); }
  if (pjs !== undefined && pjs.bindJavaScript !== undefined) {
    pjs.bindJavaScript(this);
    bound = true; }
  if(!bound) setTimeout(bindJavaScript, 250);
}

// schedule binding
bindJavaScript();

function playSketch() {

    pjs.playSketch();
}
function pauseSketch(){
    pjs.pauseSketch();      
} 
function stepSketch(){
    pjs.stepSketch();      
} 
function restartSketch(){
    pjs.restartSketch();      
} 
function changeSpeed(speed){
	pjs.changeSpeed(speed);
}
function insertValue(){
  if(!pjs.midStep()){
    var v = document.getElementById('val').value;
    if(v != ""){
      pjs.insertValue(v);
    }
  }
}
function insertFront(){
  if(!pjs.midStep()){
    var v = document.getElementById('val').value;
    if(v != ""){
      pjs.insertFront(v);
    }
  }
}
function insertBack(){
  if(!pjs.midStep()){
    var v = document.getElementById('val').value;
    if(v != ""){
      pjs.insertBack(v);
    }
  }
}
function removeFront(){
  if(!pjs.midStep()){
    pjs.removeFront();
  }
}
function removeBack(){
  if(!pjs.midStep()){
    pjs.removeBack();
  }
}
function removeValue(){
  if(!pjs.midStep()){
    var v = document.getElementById('val').value;
    if(v != ""){
      pjs.removeValue(v);
    }  }
}
function rm(){
  if(!pjs.midStep()){
    pjs.rm();
  }
}
function isEmpty(){
  pjs.isEmpty();
}
function isFull(){
  pjs.isFull();
}
function getValue(){
  pjs.getValue();
}