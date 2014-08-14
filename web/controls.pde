void playSketch(){
    anim.setMode(CONTINUOUS);
    anim.setState(RUNNING);
}
void pauseSketch(){
    anim.setState(PAUSED);
}
void stepSketch(){
    anim.setMode(STEP);
    anim.setState(RUNNING);
}
void restartSketch(){
    anim.restart();
    anim.setState(RUNNING);
}