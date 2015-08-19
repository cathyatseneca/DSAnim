
var anim;
var code;
var split;
var arr;
var jIndicator;
var jPlusIndicator;
var RED;
var GREEN;
var BLUE;
var playButton;
var pauseButton;
var stepButton;
var restartButton;
function bubble(array,sz){
    var i,j;
    var tmp;
    for(i=0;i<sz-1;i++){
        anim.addStep();
        anim.addInstruction(code,code.setHighLighter,{ln:4});
        for(j=0;j<sz-i-1;j++){
            anim.addStep();
            anim.addInstruction(code,code.setHighLighter,{ln:5});
            anim.addInstruction(jIndicator,jIndicator.setIdx,{idx:j});
            anim.addInstruction(jPlusIndicator,jPlusIndicator.setIdx,{idx:j+1});
            anim.addStep();
            anim.addInstruction(code,code.setHighLighter,{ln:6});
            if(array[j] > array[j+1]){
                anim.addStep();
                anim.addInstruction(arr,arr.setFontColour,{idx:j,r:255,g:0,b:0});
                anim.addInstruction(arr,arr.setFontColour,{idx:j+1,r:255,g:0,b:0});
                anim.addInstruction(code,code.setMultiHighLighter,{sln:7,eln:10});
                anim.addInstruction(arr,arr.swap,{from:j,to:j+1});
                tmp=array[j];
                array[j]=array[j+1];
                array[j+1]=tmp;
                anim.addStep();
                anim.addInstruction(arr,arr.setFontColour,{idx:j,r:0,g:0,b:255});
                anim.addInstruction(arr,arr.setFontColour,{idx:j+1,r:0,g:0,b:255});
            }
        }
        anim.addStep();
        anim.addInstruction(split,split.setIdx,{idx:sz-(i+1)});
        anim.addInstruction(arr,arr.setBGColour,{idx:sz-(i+1),r:189,g:252,b:201});
    }
    anim.addStep();
    anim.addInstruction(split,split.setIdx,{idx:0});
    anim.addInstruction(code,code.setHighLighter,{ln:0});
    anim.addInstruction(arr,arr.setBGColour,{idx:0,r:189,g:252,b:201});
    anim.addInstruction(jIndicator,jIndicator.hide,{});
    anim.addInstruction(jPlusIndicator,jPlusIndicator.hide,{});
}
function setSortCode(){
    var i;
    var s=[
    "void bubble(int array[],int sz){",
    "int i,j;",
    "int tmp;",
    "for(i=0;i<sz-1;i++){",
    "    for(j=0;j<sz-i-1;j++){",
    "        if(array[j] > array[j+1]){",
    "            /*swap arr[j] and arr[j+1]*/",
    "            tmp=array[j];",
    "            array[j]=array[j+1];",
    "            array[j+1]=tmp;",
    "        }",
    "    }",
    "}"
    ];
    code = AnimatedCode({code:s, x:480, y:100});
}

function setup(){
    createCanvas(800,350);
    playButton=createButton("Play");
    playButton.mousePressed(playSketch);
    pauseButton=createButton("Pause");
    pauseButton.mousePressed(pauseSketch);
    stepButton=createButton("Step");
    stepButton.mousePressed(stepSketch);
    restartButton=createButton("Restart");
    restartButton.mousePressed(restartSketch);

    RED= color(redColour);
    GREEN=color(greenColour);
    BLUE = color(blueColour);
    anim=Animation({width:800, height:350});
    setSortCode();
    anim.setBGColour(color(0,0,0));    
    var array=[];
    for(var i=0;i<15;i++){
        array.push(int(random(1,99)));
    }
    arr=AnimatedArray({initial:array,x:15,y:120});
    split=Splitter({array:arr,leftLabel: "unsorted", rightLabel:"sorted", leftColour:RED, rightColour: GREEN,idx:15});
    jIndicator = Indicator({array:arr,label:"j",isVisible:false});
    jPlusIndicator = Indicator({array:arr,label:"j+1",isUp:false,isVisible:false});

    anim.addObject(code);
    anim.addObject(arr);
    anim.addObject(split);
    anim.addObject(jIndicator);
    anim.addObject(jPlusIndicator);
    bubble(array,15);
    anim.setContinuous(true);
    anim.setPaused(false);
    anim.start();
}
function draw(){
    anim.draw();

}