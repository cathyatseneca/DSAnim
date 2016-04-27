
var anim;
var arr;
var iIndicator;
var jIndicator;
var pivotIndicator;
var code;
var playButton;
var pauseButton;
var stepButton;
var restartButton;
var speedSlider;
 
function QuickSort(array, left, right){
    if(left<right){
        var pivotpt=int((left+right)/2);
        var pivot=array[pivotpt];
        anim.addStep();
        anim.addInstruction(pivotIndicator,pivotIndicator.show);
        anim.addInstruction(pivotIndicator,pivotIndicator.setIdx,{idx:pivotpt});
        anim.addInstruction(code,code.setHighLighter,{ln:4});
        var i=left;
        var j=right-1;
        var tmp;
        anim.addStep();
        anim.addInstruction(arr,arr.swap,{from:pivotpt, to:right});
        anim.addInstruction(code,code.setHighLighter,{ln:8});
        tmp=array[pivotpt];
        array[pivotpt]=array[right];
        array[right]=tmp;
        pivotpt=right;
        anim.addStep();
        anim.addInstruction(iIndicator,iIndicator.setIdx,{idx:i});
        anim.addInstruction(jIndicator,jIndicator.setIdx,{idx:j});
        anim.addInstruction(pivotIndicator,pivotIndicator.setIdx,{idx:pivotpt});
        anim.addInstruction(code,code.setHighLighter,{ln:9}); 
        anim.addStep();
        anim.addInstruction(iIndicator,iIndicator.show);
        anim.addInstruction(jIndicator,jIndicator.show);

        while(i<j){
            while(i<right-1 && array[i]<pivot){
                anim.addStep();
                anim.addInstruction(code,code.setHighLighter,{ln:11});
                i++;
                anim.addStep();
                anim.addInstruction(iIndicator,iIndicator.setIdx,{idx:i});
                anim.addInstruction(code,code.setHighLighter,{ln:12});
            } 
            while(j > 0 && array[j]>pivot){
                anim.addStep();
                anim.addInstruction(code,code.setHighLighter,{ln:13});
                j--;
                anim.addStep();
                anim.addInstruction(jIndicator,jIndicator.setIdx,{idx:j});
                anim.addInstruction(code,code.setHighLighter,{ln:14});
            }
            if(i<j){
                anim.addStep();
                anim.addInstruction(code,code.setHighLighter,{ln:15});
                tmp=array[i];
                array[i]=array[j];
                array[j]=tmp;
                anim.addStep();
                anim.addInstruction(arr,arr.swap,{from:i, to:j});
                anim.addInstruction(code,code.setHighLighter,{ln:16});
            }
        }
        anim.addStep();
        anim.addInstruction(code,code.setHighLighter,{ln:18});
        if(i==j && array[i] < array[pivotpt]){
            i++;
            anim.addStep();
            anim.addInstruction(iIndicator,iIndicator.setIdx,{idx:i});
            anim.addInstruction(code,code.setHighLighter,{ln:19});
        }
        tmp=array[i];
        array[i]=array[pivotpt];
        array[pivotpt]=tmp;
        anim.addStep();
        anim.addInstruction(code,code.setHighLighter,{ln:20});
        if(i!=pivotpt){
            anim.addInstruction(arr,arr.swap,{from:i, to:pivotpt});

        }
        anim.addStep();
        anim.addInstruction(arr,arr.setBGColour,{idx:i,colour:mintGreenColour});

        anim.addInstruction(arr,arr.setFontColourInRange,{from:i,to:right,colour:greyColour});
        anim.addInstruction(code,code.setHighLighter,{ln:21});
        anim.addInstruction(iIndicator,iIndicator.hide);
        anim.addInstruction(jIndicator,jIndicator.hide);
        anim.addInstruction(pivotIndicator,pivotIndicator.hide)
        anim.addStep();
        anim.addInstruction(arr,arr.addGap,{idx:i-1});
        anim.addInstruction(arr,arr.addGap,{idx:i});
        QuickSort(array,left,i-1);
        anim.addStep();
        anim.addInstruction(arr,arr.removeGap,{idx:i-1});
        anim.addStep();
        anim.addInstruction(arr,arr.setFontColourInRange,{from:left,to:i,colour:greyColour});
        anim.addInstruction(arr,arr.setFontColourInRange,{from:i+1,to:right,colour:blueColour});
        anim.addInstruction(code,code.setHighLighter,{ln:22});

        QuickSort(array,i+1,right);
        anim.addStep();
        anim.addInstruction(arr,arr.removeGap,{idx:i});
    }
    anim.addStep();
    anim.addInstruction(arr,arr.setBGColourInRange,{from:left,to:right,colour:mintGreenColour});
}
 

function quickSort(array,size){
  QuickSort(array,0,size-1);
  anim.addStep();
  anim.addInstruction(arr,arr.setAllBGColour,{colour:whiteColour});
  anim.addInstruction(arr,arr.setAllFontColour,{colour:blueColour});
  anim.addInstruction(iIndicator,iIndicator.hide);
  anim.addInstruction(jIndicator,jIndicator.hide);
  anim.addInstruction(pivotIndicator,pivotIndicator.hide);
  anim.addStep();
  anim.addInstruction(code,code.setHighLighter,{ln:0});
}

function setSortCode(){
    var s=[
    "void quick(int arr[],int left,int right){",
    "  if(left<right){",
    "    int sz=right-left+1;",
    "    int pivotpt=(left+right)/2;",
    "    int i=left;",
    "    int j=right-1;",
    "    int pivot=arr[pivotpt];",
    "    swap(arr[pivotpt],arr[right]);",
    "    pivotpt=right;",
    "    while(i<j){",
    "      while(i< right-1 && arr[i]<pivot)", 
    "        i++;",
    "      while(j > 0 && arr[j]>pivot)",
    "        j--;",
    "      if(i<j)",
    "        swap(arr[i++],arr[j--]);",
    "    }",
    "    if(i==j && arr[i] < arr[pivotpt])",
    "      i++;",
    "    swap(arr[i],arr[pivotpt]);",
    "    quick(arr,left,i-1);",
    "    quick(arr,i+1,right);",
    "  }",
    "}",
    "void quick(int arr[],int size){",
    "  quick(arr,0,size-1);",
    "}" 
    ];
    code = AnimatedCode({code:s,x:580,y:50,width:320})
}
function setup(){
    createCanvas(950,500);
    playButton=createButton("Play");
    playButton.mousePressed(playSketch);
    pauseButton=createButton("Pause");
    pauseButton.mousePressed(pauseSketch);
    stepButton=createButton("Step");
    stepButton.mousePressed(stepSketch);
    restartButton=createButton("Restart");
    restartButton.mousePressed(restartSketch);
    speedSlider = createSlider(1,10,5);

    anim=Animation(950, 500);
//    anim.setColour(color(46,129,215));
    anim.setBGColour(blackColour);
    var array=[];
    for(var i=0;i<15;i++){
        array.push(int(random(1,99)));
    }
    arr=AnimatedArray({initial:array,x:15,y:230,hasBars:true,barOffset:-130});
    iIndicator = Indicator({array:arr,label:"i",colour:mintGreenColour});
    jIndicator = Indicator({array:arr,label:"j",colour:mintGreenColour});
    pivotIndicator=new Indicator({array:arr,label:"pivot",colour:whiteColour,isUp:false});
    setSortCode();
   

    anim.addObject(arr);
    anim.addObject(iIndicator);
    anim.addObject(jIndicator);
    anim.addObject(pivotIndicator);
    anim.addObject(code);
    quickSort(array,15);
    anim.start();
}
function draw(){
    changeSpeed(speedSlider.value());
    anim.draw();
}
