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

    pjs.playSketch(pjs.anim);
}
function pauseSketch(){
    pjs.pauseSketch(pjs.anim);      
} 
function stepSketch(){
    pjs.stepSketch(pjs.anim);      
} 
function restartSketch(){
    pjs.restartSketch(pjs.anim);      
} 
