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