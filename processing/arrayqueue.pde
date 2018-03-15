
Animation anim;
AnimatedCode [] memberFunctions;
AnimatedArray arr;
Indicator frontIndicator;
Indicator backIndicator;
int [] array;
int frontPtr;
int backPtr;
int queueSize;
AnimatedCode source;
int oldMemberIdx=-1;
int currMemberIdx;
AnimatedText status;
boolean midStep(){
    boolean rc=true;
    if(anim.animationState_==PAUSED){
        rc=false;
    }
    return rc;
}
void hideOldInfo(){
    if(status.isVisible()==true){
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,HIDDEN);
    }
    if(oldMemberIdx != -1 && oldMemberIdx != currMemberIdx){
        anim.addStep();
        anim.addInstruction(memberFunctions[oldMemberIdx].id_,SETVISIBILITY,HIDDEN);
    }
    oldMemberIdx=currMemberIdx;
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
    "    Queue;",
    "        front_=back_=numInQueue_=0;",
    "    }",
    "    void enqueue(int data);",
    "    void dequeue();",
    "    int front() const;",
    "    boolean isEmpty() const;",
    "    boolean isFull() const;",
    "};"
    };
    String [] s2={
    "void Queue::enqueue(int data){",
    "    if(numInQueue_!=15){",
    "        data_[back_]=data;",
    "        back_=(back_+1)%15;",
    "        numInQueue_++;",
    "    }",
    "}",
    "void Queue::dequeue(){",
    "    if(numInQueue_>0){",
    "        front_=(front_+1)%15;",
    "        numInQueue_--;",
    "    }",
    "}",
    "int Queue::front() const{",
    "    if(numInQueue_!=0){",
    "        return data_[front_];",
    "    }",
    "}",
    "boolean Queue::isEmpty() const{",
    "    return numInQueue_==0;",
    "}",
    "boolean Queue::isFull() const{",
    "    return numInQueue_==15;",
    "}"
    };
    for(i=0;i<15;i++){
      source.append(s[i]);
    }
    int [] numLines={7,6,5,3,3};
    int k=0;
    for(i=0;i<5;i++){
        memberFunctions[i]=new AnimatedCode(500,250);
        for(int j=0;j<numLines[i];j++){
            memberFunctions[i].append(s2[k]);
            memberFunctions[i].hide();
            k++;
        }
    }
}
void insertValue(int val){
    currMemberIdx=0;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(5,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(4,SET,10);
    anim.addInstruction(5,SET,2);
    if(queueSize < 15){
        queueSize++;
        array[backPtr]=val;
        anim.addStep();
        anim.addInstruction(0,MOVETO,val,backPtr,100,500);
        anim.addInstruction(5,SET,3);
        anim.addStep();
        anim.addInstruction(0,SET,backPtr,val);
        backPtr++;
        if(backPtr == 15)
            backPtr=0;
        anim.addInstruction(3,SET,backPtr);
        anim.addInstruction(5,SET,4);
        anim.addStep();
        anim.addInstruction(5,SET,5);

    }
    else{
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStringInstruction(2,SET,"Queue is Full");
    }
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.addInstruction(5,SET,0);    
    anim.start();
}
void isEmpty(){
    currMemberIdx=3;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(8,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(4,SET,12);
    anim.addInstruction(8,SET,2);
    anim.addStep();
    if(queueSize == 0){
        anim.addStringInstruction(2,SET,"isEmpty(): TRUE");
    }
    else{
        anim.addStringInstruction(2,SET,"isEmpty(): FALSE");
    }
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.addInstruction(8,SET,0);
    anim.start();
}
void isFull(){
    currMemberIdx=4;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(9,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(4,SET,13);
    anim.addInstruction(9,SET,2);
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    if(queueSize == 15){
        anim.addStringInstruction(2,SET,"isFull(): TRUE");
    }
    else{
        anim.addStringInstruction(2,SET,"isFull(): FALSE");
    }
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.addInstruction(9,SET,0);
    anim.start();
}
void rm(){
    currMemberIdx=1;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(6,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(4,SET,11);
    anim.addInstruction(6,SET,2);
    if(queueSize > 0){
        queueSize--;
        anim.addStep();
        anim.addInstruction(0,SETEMPTY,frontPtr);
        frontPtr++;
        anim.addStep();
        anim.addInstruction(6,SET,3);
        if(frontPtr == 15)
            frontPtr=0;
        anim.addInstruction(1,SET,frontPtr);
        anim.addStep();
        anim.addInstruction(6,SET,4);
    }
    else{
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStringInstruction(2,SET,"Queue is Empty");
    }
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.addInstruction(6,SET,0);
    anim.start();
}
void getValue(){
    currMemberIdx=2;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(7,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(4,SET,12);
    anim.addInstruction(7,SET,2);
    anim.addStep();

    if(queueSize == 0){
        anim.addStringInstruction(2,SET,"Queue is Empty");
        anim.addInstruction(7,SET,5);
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    }
    else{
        anim.addInstruction(7,SET,3);
        anim.addStringInstruction(2,SET,"Value at front: " + array[frontPtr]);
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    }
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.addInstruction(7,SET,0);
    anim.start();
}
void setup(){
    size(800,365);
    anim=new Animation(800, 365);
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
    memberFunctions=new AnimatedCode[5];
    source.setHighLighter(0);
    setCode();
    anim.addObject(arr);
    anim.addObject(frontIndicator);
    anim.addObject(status);
    anim.addObject(backIndicator);
    anim.addObject(source);
    for(int i=0;i<5;i++){
        anim.addObject(memberFunctions[i]);
    }
}
void draw(){
    anim.draw();

}

/*void mousePressed(){
  anim.setState(RUNNING);
}*/

