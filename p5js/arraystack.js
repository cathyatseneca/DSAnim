
var anim;
var memberFunctions=[];
var arr;
var topIndicator;
var array = ["","","","","","","","","","","","","","","",];
var topPtr=0;
var source;
var oldMemberIdx=-1;
var currMemberIdx=0;
var msg;
var enqButton;
var deqButton;
var isFullButton;
var isEmptyButton;
var topButton;
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
    ];
    var s2=[[
    "void Stack::push(int data){",
    "    if(top_!=15){",
    "       data_[top_]=data;",
    "        top_++;",
    "    }",
    "}"
    ],
    [
    "void Stack::pop(){",
    "    if(top_>0){",
    "        top_--;",
    "    }",
    "}"
    ],
    [
    "int Stack::top() const{",
    "    if(top_!=0){",
    "        return data_[top_-1];",
    "    }",
    "}"
    ],
    [
    "boolean Stack::isEmpty() const{",
    "    return top_==0;",
    "}"
    ],
    [
    "boolean Stack::isFull() const{",
    "    return top_==15;",
    "}"
    ]];
    
    source = AnimatedCode({code:s,x:500,y:5})
    for(var i=0;i<5;i++){
        memberFunctions[i]=AnimatedCode({code:s2[i],x:500,y:250,isVisible:false});
    }
}
function pushStack(){
    var val = valBox.value();
    if(val!= ""){
        currMemberIdx=0;
        hideOldInfo();
        anim.addStep();
        anim.addInstruction(memberFunctions[0],memberFunctions[0].show);
        anim.addStep();
        anim.addInstruction(source,source.setHighLighter,{ln:8});
        anim.addInstruction(memberFunctions[0],memberFunctions[0].setHighLighter,{ln:2});
        if(topPtr < 15){
            array[topPtr]=val;
            anim.addStep();
            anim.addInstruction(arr,arr.moveTo,{val:val,idx:topPtr,x:100,y:300});
            anim.addInstruction(memberFunctions[0],memberFunctions[0].setHighLighter,{ln:3});
            anim.addStep();
            anim.addInstruction(arr,arr.set,{val:val,idx:topPtr});
            topPtr++;
            anim.addInstruction(topIndicator,topIndicator.setIdx,{idx:topPtr});
            anim.addInstruction(memberFunctions[0],memberFunctions[0].setHighLighter,{ln:4});   
        }   
        else{
            anim.addStep();
            anim.addInstruction(msg,msg.show);
            anim.addInstruction(msg,msg.changeText,{str:"Stack is Full"});
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
    if(topPtr == 0){
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
    if(topPtr == 15){
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
function popStack(){
    currMemberIdx=1;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(memberFunctions[1],memberFunctions[1].show);
    anim.addStep();
    anim.addInstruction(source,source.setHighLighter,{ln:9});
    anim.addInstruction(memberFunctions[1],memberFunctions[1].setHighLighter,{ln:2});
    if(topPtr > 0){
        topPtr--;
        anim.addStep();
        anim.addInstruction(arr,arr.setEmpty,{idx:topPtr});
        anim.addInstruction(memberFunctions[1],memberFunctions[1].setHighLighter,{ln:3});
        anim.addInstruction(topIndicator,topIndicator.setIdx,{idx:topPtr});

    }
    else{
        anim.addStep();
        anim.addInstruction(msg,msg.show);
        anim.addInstruction(msg,msg.changeText,{str:"Stack is Empty"});
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

    if(topPtr==0){
       anim.addInstruction(msg,msg.changeText,{str:"Stack is Empty"});
        anim.addInstruction(memberFunctions[2],memberFunctions[2].setHighLighter,{ln:5});
        anim.addStep();
        anim.addInstruction(msg,msg.show)
    }
    else{
        anim.addInstruction(memberFunctions[2],memberFunctions[2].setHighLighter,{ln:3});
        anim.addInstruction(msg,msg.changeText,{str:"Value at top Is: " + array[topPtr-1]});
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
    enqButton=createButton("Push");
    enqButton.mousePressed(pushStack);
    deqButton=createButton("Pop");
    deqButton.mousePressed(popStack);
    isEmptyButton=createButton("isEmpty");
    isEmptyButton.mousePressed(isEmpty);
    isFullButton=createButton("isFull");
    isFullButton.mousePressed(isFull);
    topButton = createButton("top");
    topButton.mousePressed(getValue);


    anim=Animation({height:365, width:950});
    //anim.setColour(color(46,129,215));
    anim.setBGColour(blackColour);    
    msg = AnimatedText({x:200,y:250,colour:whiteColour,isVisible:false});

    arr=AnimatedArray({x:15,y:120,initial:array});
    arr.setShowIndex(true);
    topIndicator = Indicator({array:arr,label:"top",colour:whiteColour, isUp:false});
    setCode();
    anim.addObject(arr);
    anim.addObject(topIndicator);
    anim.addObject(source);
    anim.addObject(msg);
    for(var i=0;i<5;i++){
        anim.addObject(memberFunctions[i]);
    }

}
function draw(){
    anim.draw();

}