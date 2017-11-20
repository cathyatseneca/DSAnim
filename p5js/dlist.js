
var anim;
var memberFunctions=[];
var arr;
var frontIndicator;
var backIndicator;
var array = ["","","","","","","","","","","","","","","",];
var frontPtr=0;
var backPtr=0;
var queueSize=0;
var source;
var oldMemberIdx=-1;
var currMemberIdx=0;
var msg;
var enqButton;
var deqButton;
var isFullButton;
var isEmptyButton;
var frontButton;
var valBox;

function midStep(){
    rc=true;
    if(anim.isPaused()){
        rc=false;
    }
    return rc;
}
function hideOldInfo(){
    if(msg.isVisible()){
         anim.addStep();
         anim.addInstruction(msg,msg.hide);
    }
    if(oldMemberIdx != -1 && oldMemberIdx != currMemberIdx){
        anim.addStep();
        anim.addInstruction(memberFunctions[oldMemberIdx],memberFunctions[oldMemberIdx].hide);
    }
    oldMemberIdx=currMemberIdx;
}
function setCode(){

    var s=[
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
    ];
    var s2=[[
    "void Queue::enqueue(int data){",
    "    if(numInQueue_!=15){",
    "        data_[back_]=data;",
    "        back_=(back_+1)%15;",
    "        numInQueue_++;",
    "    }",
    "}"
    ],
    [
    "void Queue::dequeue(){",
    "    if(numInQueue_>0){",
    "        front_=(front_+1)%15;",
    "        numInQueue_--;",
    "    }",
    "}"
    ],
    [
    "int Queue::front() const{",
    "    if(numInQueue_!=0){",
    "        return data_[front_];",
    "    }",
    "}"
    ],
    [
    "boolean Queue::isEmpty() const{",
    "    return numInQueue_==0;",
    "}"
    ],
    [
    "boolean Queue::isFull() const{",
    "    return numInQueue_==15;",
    "}"
    ]];
    
    source = AnimatedCode({code:s,x:500,y:5})
    for(var i=0;i<5;i++){
        memberFunctions[i]=AnimatedCode({code:s2[i],x:500,y:250,isVisible:false});
    }
}
function enqueue(){
    var val = valBox.value();
    if(val!= ""){
        currMemberIdx=0;
        hideOldInfo();
        anim.addStep();
        anim.addInstruction(memberFunctions[0],memberFunctions[0].show);
        anim.addStep();
        anim.addInstruction(source,source.setHighLighter,{ln:10});
        anim.addInstruction(memberFunctions[0],memberFunctions[0].setHighLighter,{ln:2});
        if(queueSize < 15){
            queueSize++;
            array[backPtr]=val;
            anim.addStep();
            anim.addInstruction(arr,arr.moveTo,{val:val,idx:backPtr,x:100,y:300});
            anim.addInstruction(memberFunctions[0],memberFunctions[0].setHighLighter,{ln:3});
            anim.addStep();
            anim.addInstruction(arr,arr.set,{val:val,idx:backPtr});
            backPtr++;
            if(backPtr == 15)
                backPtr=0;
            anim.addInstruction(backIndicator,backIndicator.setIdx,{idx:backPtr});
            anim.addInstruction(memberFunctions[0],memberFunctions[0].setHighLighter,{ln:4});
            anim.addStep();
            anim.addInstruction(memberFunctions[0],memberFunctions[0].setHighLighter,{ln:5});
    
        }   
        else{
            anim.addStep();
            anim.addInstruction(msg,msg.show);
            anim.addInstruction(msg,msg.changeText,{str:"Queue is Full"});
        }
        anim.addStep();
        anim.addInstruction(source,source.setHighLighter,{ln:0});
        anim.addInstruction(memberFunctions[0],memberFunctions[0].setHighLighter,{ln:0});
        anim.start();
    }
}
function isEmpty(){
    currMemberIdx=3;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(memberFunctions[3],memberFunctions[3].show);
    anim.addStep();
    anim.addInstruction(source,source.setHighLighter,{ln:12});
    anim.addInstruction(memberFunctions[3],memberFunctions[3].setHighLighter,{ln:2});
    anim.addStep();
    if(queueSize == 0){
        anim.addInstruction(msg,msg.changeText,{str:"isEmpty(): TRUE"});
    }
    else{
        anim.addInstruction(msg,msg.changeText,{str:"isEmpty(): FALSE"});
    }
    anim.addInstruction(msg,msg.show)
    anim.addStep();
    anim.addInstruction(source,source.setHighLighter,{ln:0});
    anim.addInstruction(memberFunctions[3],memberFunctions[3].setHighLighter,{ln:0});
    anim.start();
}
function isFull(){
    currMemberIdx=4;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(memberFunctions[4],memberFunctions[4].show);
    anim.addStep();
    anim.addInstruction(source,source.setHighLighter,{ln:13});
    anim.addInstruction(memberFunctions[4],memberFunctions[4].setHighLighter,{ln:2});
    anim.addStep();
    anim.addInstruction(msg,msg.show)

    if(queueSize == 15){
         anim.addInstruction(msg,msg.changeText,{str:"isFull(): TRUE"});

    }
    else{
        anim.addInstruction(msg,msg.changeText,{str:"isFull(): FALSE"});
    }
    anim.addStep();
    anim.addInstruction(source,source.setHighLighter,{ln:0});
    anim.addInstruction(memberFunctions[4],memberFunctions[4].setHighLighter,{ln:0});
    anim.start();
}
function dequeue(){
    currMemberIdx=1;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(memberFunctions[1],memberFunctions[1].show);
    anim.addStep();
    anim.addInstruction(source,source.setHighLighter,{ln:11});
    anim.addInstruction(memberFunctions[1],memberFunctions[1].setHighLighter,{ln:2});
    if(queueSize > 0){
        queueSize--;
        anim.addStep();
        anim.addInstruction(arr,arr.setEmpty,{idx:frontPtr});
        frontPtr++;
        anim.addStep();
        anim.addInstruction(memberFunctions[1],memberFunctions[1].setHighLighter,{ln:3});
        if(frontPtr == 15)
            frontPtr=0;
        anim.addInstruction(frontIndicator,frontIndicator.setIdx,{idx:frontPtr})
        anim.addStep();
        anim.addInstruction(memberFunctions[1],memberFunctions[1].setHighLighter,{ln:4});
    }
    else{
        anim.addStep();
        anim.addInstruction(msg,msg.show);
        anim.addInstruction(msg,msg.changeText,{str:"Queue is Empty"});
    }
    anim.addStep();

    anim.addInstruction(source,source.setHighLighter,{ln:0});
    anim.addInstruction(memberFunctions[1],memberFunctions[1].setHighLighter,{ln:0});
    anim.start();
}
function getValue(){
    currMemberIdx=2;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(memberFunctions[2],memberFunctions[2].show);
    anim.addStep();

    anim.addInstruction(source,source.setHighLighter,{ln:12});
    anim.addInstruction(memberFunctions[2],memberFunctions[2].setHighLighter,{ln:2});
    anim.addStep();

    if(queueSize == 0){
       anim.addInstruction(msg,msg.changeText,{str:"Queue is Empty"});
        anim.addInstruction(memberFunctions[2],memberFunctions[2].setHighLighter,{ln:5});
        anim.addStep();
        anim.addInstruction(msg,msg.show)
    }
    else{
        anim.addInstruction(memberFunctions[2],memberFunctions[2].setHighLighter,{ln:3});
        anim.addInstruction(msg,msg.changeText,{str:"Value at front: " + array[frontPtr]});
        anim.addStep();
        anim.addInstruction(msg,msg.show);
    }
    anim.addStep();

    anim.addInstruction(source,source.setHighLighter,{ln:0});
    anim.addInstruction(memberFunctions[2],memberFunctions[2].setHighLighter,{ln:0});
    anim.start();
}
function setup(){
    createCanvas(950,365);
    valBox = createInput();
    enqButton=createButton("Enqueue");
    enqButton.mousePressed(enqueue);
    deqButton=createButton("Dequeue");
    deqButton.mousePressed(dequeue);
    isEmptyButton=createButton("isEmpty");
    isEmptyButton.mousePressed(isEmpty);
    isFullButton=createButton("isFull");
    isFullButton.mousePressed(isFull);
    frontButton = createButton("front");
    frontButton.mousePressed(getValue);


    anim=Animation({height:365, width:950});
    //anim.setColour(color(46,129,215));
    anim.setBGColour(blackColour);    
    msg = AnimatedText({x:200,y:250,colour:whiteColour,isVisible:false});

    arr=AnimatedArray({x:15,y:120,initial:array});
    arr.setShowIndex(true);
    frontIndicator = Indicator({array:arr,label:"front",colour:whiteColour,isUp:false});
    backIndicator = Indicator({array:arr,label:"back",colour:whiteColour});
    setCode();
    anim.addObject(arr);
    anim.addObject(frontIndicator);
    anim.addObject(backIndicator);
    anim.addObject(source);
    anim.addObject(msg);
    for(var i=0;i<5;i++){
        anim.addObject(memberFunctions[i]);
    }

}
function draw(){
    anim.draw();

}