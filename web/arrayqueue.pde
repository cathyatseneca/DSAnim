
Animation anim;
AnimatedCode code;
AnimatedArray arr;
Indicator frontIndicator;
Indicator backIndicator;
int [] array;
int frontPtr;
int backPtr;
int queueSize;
boolean midStep(){
    boolean rc=true;
    if(anim.animationState_==PAUSED){
        rc=false;
    }
    return rc;
}
void insert(int val){
    if(status.isVisible()==true){
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,HIDDEN);
    }
    if(queueSize < 15){
        queueSize++;
        array[backPtr]=val;
        anim.addStep();
        anim.addInstruction(0,MOVETO,val,backPtr,100,500);
        anim.addStep();
        anim.addInstruction(0,SET,backPtr,val);
        backPtr++;
        if(backPtr == 15)
            backPtr=0;
        anim.addInstruction(3,SET,backPtr);
        anim.start();
    }
}
void isEmpty(){
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    if(queueSize == 0){
        anim.addStringInstruction(2,SET,"isEmpty(): TRUE");
    }
    else{
        anim.addStringInstruction(2,SET,"isEmpty(): FALSE");
    }
    anim.start();
}
void isFull(){
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    if(queueSize == 15){
        anim.addStringInstruction(2,SET,"isFull(): TRUE");
    }
    else{
        anim.addStringInstruction(2,SET,"isFull(): FALSE");
    }
    anim.start();
}
void removeValue(){
    if(status.isVisible()==true){
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,HIDDEN);
    }
    if(queueSize > 0){
        queueSize--;
        anim.addStep();
        anim.addInstruction(0,SETEMPTY,frontPtr);
        frontPtr++;
        if(frontPtr == 15)
            frontPtr=0;
        anim.addInstruction(1,SET,frontPtr);

    }
    else{
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStringInstruction(2,SET,"Queue is Empty");
    }
    anim.start();
}
void getValue(){
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    if(queueSize == 0){
        anim.addStringInstruction(2,SET,"Queue is Empty");

    }
    else{
       anim.addStringInstruction(2,SET,"Value at front: " + array[frontPtr]);
    }
    anim.start();
}
void setup(){
    size(800,350);
    anim=new Animation(800, 350);
    //anim.setColour(color(46,129,215));
    anim.setColour(backgroundColour);    
    array=new int[15];
    arr=new AnimatedArray(15,15,120);
    arr.setShowIndex(true);
    status = new AnimatedText("",300,250,36,whiteColour);
    status.hide();
    frontIndicator = new Indicator("front",whiteColour,30,30,120);
    frontIndicator.pointDown();
    backIndicator = new Indicator("back",whiteColour,30,30,150);
    int tmp;
    anim.addObject(arr);
    anim.addObject(frontIndicator);
    anim.addObject(status);
    anim.addObject(backIndicator);
}
void draw(){
    anim.draw();

}

/*void mousePressed(){
  anim.setState(RUNNING);
}*/

