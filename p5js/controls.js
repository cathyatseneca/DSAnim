function playSketch(){
    anim.setContinuous(true);
    anim.setPaused(false);
}
function pauseSketch(){
    anim.setPaused(true);
}
function stepSketch(){
    anim.setContinuous(false);
    anim.setPaused(false);
}
function restartSketch(){
    anim.restart();
    anim.setPaused(false);
}
function changeSpeed(speed){
	var inverse=11-speed;
    anim.changeSpeed(inverse);
}