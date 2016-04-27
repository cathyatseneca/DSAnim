
var anim;
var code;
var split;
var arr;
var minIndicator;
var jIndicator;
var playButton;
var pauseButton;
var stepButton;
var restartButton;
var speedSlider;
var RED;
var GREEN;
var BLUE;
var MINTGREEN;
var MYSTERY;
function selectionSort(array,size){
    var minIdx;
    var tmp;
    for(var i=0;i<size;i++){
        anim.addStep();
        anim.addInstruction(code,code.setHighLighter,{ln:4});
        anim.addInstruction(arr,arr.setBGColour,{idx:i,colour:MYSTERY});
        minIdx=i;
        anim.addStep();
        anim.addInstruction(code,code.setHighLighter,{ln:5});
        anim.addStep();
        anim.addInstruction(code,code.setHighLighter,{ln:6});
        anim.addInstruction(jIndicator,jIndicator.setIdx,{idx:i});
        anim.addInstruction(minIndicator,minIndicator.setIdx,{idx:i});
        anim.addInstruction(jIndicator,jIndicator.show);
        anim.addInstruction(minIndicator,minIndicator.show);
        for(var j=i;j<size;j++){
            anim.addStep();
            anim.addInstruction(jIndicator,jIndicator.setIdx,{idx:j});
            anim.addInstruction(code,code.setHighLighter,{ln:7});
            if(array[j] < array[minIdx]){
                anim.addStep();
                anim.addInstruction(minIndicator,minIndicator.setIdx,{idx:j});
                anim.addInstruction(code,code.setHighLighter,{ln:8});
                minIdx=j;
            }
            anim.addStep();
            anim.addInstruction(code,code.setHighLighter,{ln:6});
        }
        if(minIdx!=i){
            anim.addStep();
            anim.addInstruction(jIndicator,jIndicator.hide);
            anim.addInstruction(minIndicator,minIndicator.hide);
            anim.addInstruction(arr,arr.swap,{from:minIdx,to:i});
            anim.addInstruction(code,code.setMultiHighLighter,{sln:11, eln:14});
            tmp=array[i];
            array[i]=array[minIdx];
            array[minIdx]=tmp;
        }
        else{
            anim.addStep();
            anim.addInstruction(jIndicator,jIndicator.hide);
            anim.addInstruction(minIndicator,minIndicator.hide);
        }
        anim.addStep();
        anim.addInstruction(split,split.setIdx,{idx:(i+1)});
        anim.addInstruction(arr,arr.setBGColour,{idx:i,colour:MINTGREEN});
    }
    anim.addStep();
    anim.addInstruction(split,split.setIdx,{idx:size});
    anim.addInstruction(minIndicator,minIndicator.hide);
    anim.addInstruction(jIndicator,jIndicator.hide);
    anim.addInstruction(code,code.setHighLighter,{ln:0});
}
function setSortCode(){
    var s=[
    "void selectionSort(int arr[],int size){",
    "  int minIdx;",
    "  int tmp;",
    "  for(int i=0;i<size;i++){",
    "    minIdx=i;",
    "    for(int j=i;j<size;j++){",
    "      if(arr[j] < arr[minIdx]){",
    "        minIdx=j;",
    "      }",
    "    }",
    "    //swap",
    "    tmp=arr[i];",
    "    arr[i]=arr[minIdx];",
    "    arr[minIdx]=tmp;",
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
    RED= color(redColour);
    GREEN=color(greenColour);
    MINTGREEN = color(189,252,201);
    MYSTERY = color(152,245,255);
    anim=Animation(950, 400);
    setSortCode();
    anim.setBGColour(color(0,0,0));
    var array=[];
    for(var i=0;i<15;i++){
        array.push(int(random(1,99)));
    }
    arr=AnimatedArray({initial:array,x:15,y:200});
    split=Splitter({array:arr,leftLabel:"sorted",rightLabel:"unsorted",
                        leftColour:GREEN,rightColour:RED,idx:0});
    minIndicator = Indicator({array:arr,label:"minIdx",isVisible:true});
    jIndicator = Indicator({array:arr,label:"j",isVisible:false, isUp:false});


    var tmp;
    anim.addObject(code);
    anim.addObject(split);
    anim.addObject(minIndicator);
    anim.addObject(arr);
    anim.addObject(jIndicator);
    selectionSort(array,15);
    anim.start();
}
function draw(){
    changeSpeed(speedSlider.value());
    anim.draw();
}
