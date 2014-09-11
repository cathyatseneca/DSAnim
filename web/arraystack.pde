
Animation anim;
AnimatedCode code;
AnimatedArray arr;
Indicator topIndicator;
int [] array;
int topPtr;
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
    if(topPtr < 15){
        array[topPtr]=val;
        topPtr++;
        anim.addStep();
        anim.addInstruction(0,MOVETO,val,topPtr-1,100,500);
        anim.addStep();
        anim.addInstruction(0,SET,topPtr-1,val);
        anim.addInstruction(1,SET,topPtr);
        anim.start();
    }
}
void isEmpty(){
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    if(topPtr == 0){
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
    if(topPtr == 15){
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
    if(topPtr > 0){
        topPtr--;
        anim.addStep();
        anim.addInstruction(0,SETEMPTY,topPtr);
        anim.addInstruction(1,SET,topPtr);
        anim.start();
    }

}
void getValue(){
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    if(topPtr == 0){
        anim.addStringInstruction(2,SET,"Stack is Empty");

    }
    else{
       anim.addStringInstruction(2,SET,"Value at top: " + array[topPtr-1]);
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
    topIndicator = new Indicator("top",whiteColour,30,30,120);
    topIndicator.pointDown();
    int tmp;
    anim.addObject(arr);
    anim.addObject(topIndicator);
    anim.addObject(status);
}
void draw(){
    anim.draw();

}

/*void mousePressed(){
  anim.setState(RUNNING);
}*/

