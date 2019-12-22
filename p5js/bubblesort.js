
var anim;
var code;
var split;
var arr;
var jIndicator;
var jPlusIndicator;

var playButton;
var pauseButton;
var stepButton;
var restartButton;
var speedSlider;
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
                anim.addInstruction(arr,arr.setFontColour,{idx:j,colour:redColour});
                anim.addInstruction(arr,arr.setFontColour,{idx:j+1,colour:redColour});
                anim.addInstruction(code,code.setMultiHighLighter,{sln:7,eln:10});
                anim.addInstruction(arr,arr.swap,{from:j,to:j+1});
                tmp=array[j];
                array[j]=array[j+1];
                array[j+1]=tmp;
                anim.addStep();
                anim.addInstruction(arr,arr.setFontColour,{idx:j,colour:blueColour});
                anim.addInstruction(arr,arr.setFontColour,{idx:j+1,colour:blueColour});
            }
        }
        anim.addStep();
        anim.addInstruction(split,split.setIdx,{idx:sz-(i+1)});
        anim.addInstruction(arr,arr.setBGColour,{idx:sz-(i+1),colour:mintGreenColour});
    }
    anim.addStep();
    anim.addInstruction(split,split.setIdx,{idx:0});
    anim.addInstruction(code,code.setHighLighter,{ln:0});
    anim.addInstruction(arr,arr.setBGColour,{idx:0,colour:mintGreenColour});
    anim.addInstruction(jIndicator,jIndicator.hide);
    anim.addInstruction(jPlusIndicator,jPlusIndicator.hide);
}
function setSortCode(){
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
    code = AnimatedCode({code:s, x:530, y:100});
}

function setup(){
    createCanvas(900,400);
    playButton=createButton("Play");
    playButton.mousePressed(playSketch);
    playButton.position (15, 425);

    pauseButton=createButton("Pause");
    pauseButton.mousePressed(pauseSketch);
    pauseButton.position(70, 425);

    stepButton=createButton("Step");
    stepButton.mousePressed(stepSketch);
    stepButton.position(135, 425);


    restartButton=createButton("Restart");
    restartButton.mousePressed(restartSketch);
    pauseButton.position(70, 425);

    speedSlider = createSlider(1,10,5);
    speedSlider.position(270, 425);

    anim=Animation({width:800, height:350});
    setSortCode();
    anim.setBGColour(color(0,0,0));    
    var array=[];
    for(var i=0;i<15;i++){
        array.push(int(random(1,99)));
    }
    arr=AnimatedArray({initial:array,x:15,y:120, hasBars: true});
    split=Splitter({array:arr,leftLabel: "unsorted", rightLabel:"sorted", leftColour:redColour, rightColour: greenColour,idx:15});
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
    changeSpeed(speedSlider.value());
    anim.draw();

}