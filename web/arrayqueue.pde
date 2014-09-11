
Animation anim;
AnimatedCode code;
AnimatedArray arr;
Indicator frontIndicator;
Indicator backIndicator;
int [] array;
int frontPtr;
int backPtr;
int queueSize;
AnimatedCode source;
boolean midStep(){
    boolean rc=true;
    if(anim.animationState_==PAUSED){
        rc=false;
    }
    return rc;
}
void setCode(){
    int i;
    String [] s={
    "class Queue{",
    "    int data_[15];",
    "    int front_;",
    "    int back_;",
    "    int numInQueue_;",
    "public:",
    "    Queue{",
    "        front_=back_=numInQueue_=0;",
    "    }",
    "    void enqueue(int data){",
    "        if(numInQueue_!=15){",
    "            data_[back_]=data;",
    "            back_=(back_+1)%15;",
    "            numInQueue_++;",
    "        }",
    "    }",
    "    void dequeue(){",
    "        if(numInQueue_>0){",
    "            front_=(front_+1)%15;",
    "            numInQueue_--;",
    "        }",
    "    }",
    "    int front() const{",
    "        if(numInQueue_!=0){",
    "            return data_[front_];",
    "        }",
    "    }",
    "    boolean isEmpty() const{",
    "        return numInQueue_==0;",
    "    }",
    "    boolean isFull() const{",
    "        return numInQueue_==15;",
    "    }",
    "};"
    };
    for(i=0;i<34;i++){
      source.append(s[i]);
    }
}
void insert(int val){
    if(status.isVisible()==true){
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,HIDDEN);
    }
    anim.addStep();
    anim.addInstruction(4,SET,11);

    if(queueSize < 15){
        queueSize++;
        array[backPtr]=val;
        anim.addStep();
        anim.addInstruction(0,MOVETO,val,backPtr,100,500);
        anim.addInstruction(4,SET,12);
        anim.addStep();
        anim.addInstruction(0,SET,backPtr,val);
        backPtr++;
        if(backPtr == 15)
            backPtr=0;
        anim.addInstruction(3,SET,backPtr);
        anim.addInstruction(4,SET,13);
        anim.addStep();
        anim.addInstruction(4,SET,14);
        anim.addStep();
        anim.addInstruction(4,SET,0);
    }
    else{
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStringInstruction(2,SET,"Queue is Full");
    }
    anim.start();
}
void isEmpty(){
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    anim.addInstruction(4,SET,29);
    anim.addStep();
    if(queueSize == 0){
        anim.addStringInstruction(2,SET,"isEmpty(): TRUE");
    }
    else{
        anim.addStringInstruction(2,SET,"isEmpty(): FALSE");
    }
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.start();
}
void isFull(){
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    anim.addInstruction(4,SET,32);
    anim.addStep();
    if(queueSize == 15){
        anim.addStringInstruction(2,SET,"isFull(): TRUE");
    }
    else{
        anim.addStringInstruction(2,SET,"isFull(): FALSE");
    }
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.start();
}
void removeValue(){
    anim.addStep();
    anim.addInstruction(4,SET,18);
    if(status.isVisible()==true){
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,HIDDEN);
    }
    if(queueSize > 0){
        queueSize--;
        anim.addStep();
        anim.addInstruction(0,SETEMPTY,frontPtr);
        frontPtr++;
        anim.addStep();
        anim.addInstruction(4,SET,19);
        if(frontPtr == 15)
            frontPtr=0;
        anim.addInstruction(1,SET,frontPtr);
        anim.addStep();
        anim.addInstruction(4,SET,20);
    }
    else{
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStringInstruction(2,SET,"Queue is Empty");
    }
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.start();
}
void getValue(){
    anim.addStep();
    anim.addInstruction(4,SET,24);
    anim.addStep();

    if(queueSize == 0){
        anim.addStringInstruction(2,SET,"Queue is Empty");
        anim.addInstruction(4,SET,26);
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    }
    else{
        anim.addInstruction(4,SET,25);
        anim.addStringInstruction(2,SET,"Value at front: " + array[frontPtr]);
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    }
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.start();
}
void setup(){
    size(800,500);
    anim=new Animation(800, 500);
    //anim.setColour(color(46,129,215));
    anim.setColour(backgroundColour);    
    array=new int[15];
    arr=new AnimatedArray(15,15,120);
    arr.setShowIndex(true);
    status = new AnimatedText("",200,250,36,whiteColour);
    status.hide();
    frontIndicator = new Indicator("front",whiteColour,30,30,120);
    frontIndicator.pointDown();
    backIndicator = new Indicator("back",whiteColour,30,30,150);
    source = new AnimatedCode(500,5);
    source.setHighLighter(0);
    setCode();
    int tmp;
    anim.addObject(arr);
    anim.addObject(frontIndicator);
    anim.addObject(status);
    anim.addObject(backIndicator);
    anim.addObject(source);
}
void draw(){
    anim.draw();

}

/*void mousePressed(){
  anim.setState(RUNNING);
}*/

