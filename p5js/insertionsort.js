
var anim;
var code;
var split;
var arr;
var jIndicator;
var animatedVar;
var playButton;
var pauseButton;
var stepButton;
var restartButton;
var speedSlider;
function insertion(array,size){
    var curr;
    var i;
    var j;
    anim.addStep();
    anim.addInstruction(arr,arr.setBGColour,{idx:0,colour:mintGreenColour});
    for(i=0;i<size;i++){
        anim.addStep();
        anim.addInstruction(code,code.setHighLighter,{ln:4});
        curr=array[i];
        anim.addStep();
        anim.addInstruction(code,code.setHighLighter,{ln:5});
        anim.addInstruction(split,split.setIdx,{idx:i+1});
        anim.addInstruction(arr,arr.moveFrom,{x:30,y:315,idx:i});
        anim.addStep();
        anim.addInstruction(animatedVar,animatedVar.set,{value:curr});
        anim.addInstruction(animatedVar,animatedVar.setFilled);
        anim.addInstruction(jIndicator,jIndicator.show);
        anim.addInstruction(jIndicator,jIndicator.setIdx,{idx:i});

        for(j=i;j>0 && array[j-1] > curr;j--){
            anim.addStep();
            anim.addInstruction(code,code.setHighLighter,{ln:6});
            anim.addInstruction(jIndicator,jIndicator.setIdx,{idx:j});
            array[j]=array[j-1];
            anim.addStep();
            anim.addInstruction(arr,arr.moveLocation,{from:j-1,to:j});
            anim.addInstruction(code,code.setHighLighter,{ln:7});
        }

        array[j]=curr;
        anim.addStep();
        anim.addInstruction(jIndicator,jIndicator.hide);
        anim.addInstruction(animatedVar,animatedVar.setEmpty);
        anim.addInstruction(code,code.setHighLighter,{ln:9});
        anim.addInstruction(arr,arr.setBGColour,{idx:i,colour:mintGreenColour});
        anim.addInstruction(arr,arr.moveTo,{x:30,y:315,idx:j,val:curr});

    }
    anim.addStep();
    anim.addInstruction(code,code.setHighLighter,{ln:0});
    anim.addInstruction(jIndicator,jIndicator.hide);
}
function setSortCode(){
    var s=[
    "void insertionSort(int arr[],int size){",
    "  int curr;",
    "  int i,j;",
    "  for(i=0;i<size;i++){",
    "    curr=arr[i];",
    "    for(j=i;j>0 && arr[j-1] > curr;j--){",
    "      arr[j]=arr[j-1];",
    "    }",
    "    arr[j]=curr;",
    "  }",
    "}"
    ];
    code = AnimatedCode({code:s,x:520,y:80});
}

function setup(){
    createCanvas(950,400);
    playButton=createButton("Play");
    playButton.mousePressed(playSketch);
    pauseButton=createButton("Pause");
    pauseButton.mousePressed(pauseSketch);
    stepButton=createButton("Step");
    stepButton.mousePressed(stepSketch);
    restartButton=createButton("Restart");
    restartButton.mousePressed(restartSketch);
    speedSlider = createSlider(1,10,5);
    anim=Animation(950, 400);
    code=AnimatedCode(480,100);
    setSortCode();
    anim.setBGColour(blackColour);
    var array=[];
    for(var i=0;i<15;i++){
        array.push(int(random(1,99)));
    }
    arr=AnimatedArray({initial:array,x:15,y:200,hasBars:true,barOffset:-120});
    split=Splitter({array:arr,leftLabel:"sorted",rightLabel:"unsorted",
                        leftColour:greenColour,rightColour:redColour,idx:0,
                        yOffset: -100});
    jIndicator = Indicator({array:arr,label:"",isVisible:false, isUp:false});

    animatedVar = AnimatedVariable({x:15,y:300});


    anim.addObject(code);
    anim.addObject(animatedVar);
    anim.addObject(split);
    anim.addObject(jIndicator);
    anim.addObject(arr);
    insertion(array,15);
    anim.start();
}
function draw(){
    changeSpeed(speedSlider.value());
    anim.draw();
}
