
Animation anim;
AnimatedCode [] memberFunctions;
AnimatedCode source;
AnimatedArray arr;
Indicator topIndicator;
int [] array;
int topPtr;
int oldMemberIdx=-1;
int currMemberIdx;
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
    "class Stack{",
    "    int data_[15];",
    "    int top_;",
    "public:",
    "    Stack;",
    "        top_=0;",
    "    }",
    "    void push(int data);",
    "    void pop();",
    "    int top() const;",
    "    boolean isEmpty() const;",
    "    boolean isFull() const;",
    "};"
    };
    String [] s2={
    "void Stack::push(int data){",
    "    if(top_!=15){",
    "       data_[top_]=data;",
    "        top_++;",
    "    }",
    "}",
    "void Stack::pop(){",
    "    if(top_>0){",
    "        top_--;",
    "    }",
    "}",
    "int Stack::top() const{",
    "    if(top_!=0){",
    "        return data_[top_-1];",
    "    }",
    "}",
    "boolean Stack::isEmpty() const{",
    "    return top_==0;",
    "}",
    "boolean Stack::isFull() const{",
    "    return top_==15;",
    "}"
    };
    for(i=0;i<13;i++){
      source.append(s[i]);
    }
    int [] numLines={6,5,5,3,3};
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
    anim.addInstruction(4,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(3,SET,8);
    anim.addInstruction(4,SET,2);

    if(topPtr < 15){
        array[topPtr]=val;
        topPtr++;
        anim.addStep();
        anim.addInstruction(4,SET,3);
        anim.addInstruction(0,MOVETO,val,topPtr-1,100,500);
        anim.addStep();
        anim.addInstruction(0,SET,topPtr-1,val);
        anim.addInstruction(1,SET,topPtr);
        anim.addInstruction(4,SET,4);
    }
    else{
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStringInstruction(2,SET,"Stack is full");
        anim.addInstruction(4,SET,6);

    }
    anim.addStep();
    anim.addInstruction(4,SET,0);
    anim.addInstruction(3,SET,0);
    anim.start();

}
void isEmpty(){
    currMemberIdx=3;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(7,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(3,SET,11);
    anim.addInstruction(7,SET,2);
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    if(topPtr == 0){
        anim.addStringInstruction(2,SET,"isEmpty(): TRUE");
    }
    else{
        anim.addStringInstruction(2,SET,"isEmpty(): FALSE");
    }
    anim.addStep();
    anim.addInstruction(7,SET,0);
    anim.addInstruction(3,SET,0);
    anim.start();
}
void isFull(){
    currMemberIdx=4;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(8,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(3,SET,12);
    anim.addInstruction(8,SET,2);
    anim.addStep();
    anim.addInstruction(2,SETVISIBILITY,VISIBLE);
    if(topPtr == 15){
        anim.addStringInstruction(2,SET,"isFull(): TRUE");
    }
    else{
        anim.addStringInstruction(2,SET,"isFull(): FALSE");
    }
    anim.addStep();
    anim.addInstruction(8,SET,0);
    anim.addInstruction(3,SET,0);
    anim.start();
}
void rm(){
    currMemberIdx=1;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(5,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(3,SET,9);
    anim.addInstruction(5,SET,2);
    if(topPtr > 0){
        topPtr--;
        anim.addStep();
        anim.addInstruction(5,SET,3);
        anim.addStep();
        anim.addInstruction(0,SETEMPTY,topPtr);
        anim.addInstruction(1,SET,topPtr);
    }
    else{
        anim.addStep();
        anim.addInstruction(5,SET,5);
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStringInstruction(2,SET,"Stack is empty");

    }
    anim.addStep();
    anim.addInstruction(3,SET,0);
    anim.addInstruction(5,SET,0);
    anim.start();
}
void getValue(){
    currMemberIdx=2;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(6,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(3,SET,10);
    anim.addInstruction(6,SET,2);
    if(topPtr == 0){
        anim.addStep();
        anim.addInstruction(6,SET,5);
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStringInstruction(2,SET,"Stack is Empty");
    }
    else{
        anim.addStep();
        anim.addInstruction(6,SET,3);
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStringInstruction(2,SET,"Value at top: " + array[topPtr-1]);
    }
    anim.addStep();
    anim.addInstruction(3,SET,0);
    anim.addInstruction(6,SET,0);
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
    status = new AnimatedText("",200,250,36,whiteColour);
    status.hide();
    topIndicator = new Indicator("top",whiteColour,30,30,120);
    topIndicator.pointDown();
    source = new AnimatedCode(500,5);
    memberFunctions=new AnimatedCode[5];
    source.setHighLighter(0);
    setCode();
    anim.addObject(arr);
    anim.addObject(topIndicator);
    anim.addObject(status);
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

