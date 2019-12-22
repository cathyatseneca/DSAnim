
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
    anim.addStep();
    anim.addInstruction(code,code.setHighLighter,{ln:2});
    if(right-left >= 1){
        var pivotpt=int((left+right)/2);
        anim.addStep();
        anim.addInstruction(pivotIndicator,pivotIndicator.setIdx,{idx:pivotpt});
        anim.addInstruction(pivotIndicator,pivotIndicator.show);
        anim.addInstruction(code,code.setHighLighter,{ln:3});

        var pivot=array[pivotpt];
        anim.addStep();
        anim.addInstruction(code,code.setHighLighter,{ln:4});


        anim.addStep();
        anim.addInstruction(arr,arr.swap,{from:pivotpt, to:right});
        anim.addInstruction(code,code.setHighLighter,{ln:5});
        var tmp;
        tmp=array[pivotpt];
        array[pivotpt]=array[right];
        array[right]=tmp;
        pivotpt=right;



        var j=left;
        var i=left-1;

        anim.addStep();
        anim.addInstruction(iIndicator,iIndicator.setIdx,{idx:i});
        anim.addInstruction(jIndicator,jIndicator.setIdx,{idx:j});
        anim.addInstruction(pivotIndicator,pivotIndicator.setIdx,{idx:pivotpt});
        anim.addInstruction(code,code.setHighLighter,{ln:5}); 

        anim.addStep();
        anim.addInstruction(iIndicator,iIndicator.show);
        anim.addInstruction(code,code.setHighLighter,{ln:6});

        for(j=left;j<right;j++){

            anim.addStep();
            anim.addInstruction(jIndicator,jIndicator.show);
            anim.addInstruction(code,code.setHighLighter,{ln:7});
            anim.addStep();
            anim.addInstruction(code,code.setHighLighter,{ln:8});

             if(array[j]<=pivot){

                i=i+1;
                anim.addStep();
                anim.addInstruction(iIndicator,iIndicator.setIdx,{idx:i});
                anim.addInstruction(code,code.setHighLighter,{ln:9});

                anim.addStep();
                anim.addInstruction(arr,arr.swap,{from:i, to:j});
                anim.addInstruction(code,code.setHighLighter,{ln:10});
                tmp=array[i];
                array[i]=array[j]
                array[j]=tmp;
            }

            anim.addStep();
            anim.addInstruction(jIndicator,jIndicator.setIdx,{idx:j+1});
            anim.addInstruction(code,code.setHighLighter,{ln:7}); 
        }
        i=i+1;
        anim.addStep();
        anim.addInstruction(iIndicator,iIndicator.setIdx,{idx:i});
        anim.addInstruction(code,code.setHighLighter,{ln:13});

        tmp=array[i];
        array[i]=array[pivotpt];
        array[pivotpt]=tmp;
        anim.addStep();
        anim.addInstruction(arr,arr.swap,{from:i, to: pivotpt});
        anim.addInstruction(code,code.setHighLighter,{ln:14});

        //colour pivot mint green to indicate it is sorted
        anim.addStep();
        anim.addInstruction(arr,arr.setBGColour,{idx:i,colour:mintGreenColour});

        //grey out values from pivot+1 to right 
        anim.addInstruction(arr,arr.setFontColourInRange,{from:i+1,to:right,colour:greyColour});
        anim.addInstruction(code,code.setHighLighter,{ln:15});

        //hide indicators
        anim.addInstruction(iIndicator,iIndicator.hide);
        anim.addInstruction(jIndicator,jIndicator.hide);
        anim.addInstruction(pivotIndicator,pivotIndicator.hide)

        //create gaps between pivot and the two pieces of the array
        if(i!=left || i!= right){
            anim.addStep();
        }
        if(i!=left){
            anim.addInstruction(arr,arr.addGap,{idx:i-1});
        }
        if(i!=right){
            anim.addInstruction(arr,arr.addGap,{idx:i});
        }


        QuickSort(array,left,i-1);
        if(i!=left){
            anim.addStep();
            anim.addInstruction(arr,arr.removeGap,{idx:i-1});
        }

        anim.addStep();
        anim.addInstruction(arr,arr.setFontColourInRange,{from:left,to:i+1,colour:greyColour});
        anim.addInstruction(arr,arr.setFontColourInRange,{from:i+1,to:right,colour:blueColour});
        anim.addInstruction(code,code.setHighLighter,{ln:16});

         QuickSort(array,i+1,right);
         if(i!=right){
             anim.addStep();
             anim.addInstruction(arr,arr.removeGap,{idx:i});
         }
    }
    anim.addStep();
    anim.addInstruction(arr,arr.setBGColourInRange,{from:left,to:right,colour:mintGreenColour});
}
 

function quickSort(array,size){
    anim.addStep();
    anim.addInstruction(code,code.setHighLighter,{ln:20});
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
    "void quick(int arr[], int left, int right){",
    "   if(right-left >= 1){",
    "       int pivotpt=(left+right)/2",
    "       int pivot = array[pivotpt]",
    "       swap(arr[pivotpt],arr[right]",
    "       int i=left-1;",
    "       for(int j=left;j<right;j++){",
    "           if(array[j]<=pivot){",
    "               i=i+1;",
    "               swap(arr[i],arr[j]);",
    "           }",
    "       }",
    "       i=i+1;",
    "       swap(arr[i],arr[right]);",
    "       quick(arr,left,i-1);",
    "       quick(arr,i+1,right);",
    "   }",
    "}",
    "void quick(int arr[],int size){",
    "  quick(arr,0,size-1);",
    "}" 
    ];
    code = AnimatedCode({code:s,x:580,y:50,width:325})
}
function setup(){
    createCanvas(950,400);
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
    restartButton.position(195, 425);


    speedSlider = createSlider(1,10,5);
    speedSlider.position(270, 425);

    anim=Animation(950, 400);
//    anim.setColour(color(46,129,215));
    anim.setBGColour(blackColour);
    var array=[];
    for(var i=0;i<15;i++){
        array.push(int(random(1,99)));
    }
    arr=AnimatedArray({initial:array,x:45,y:230,hasBars:true,barOffset:-130});
    iIndicator = Indicator({array:arr,label:"i",colour:mintGreenColour, isUp:false,isVisible:false});
    jIndicator = Indicator({array:arr,label:"j",colour:mintGreenColour,isVisible:false});
    pivotIndicator=new Indicator({array:arr,label:"pivot",colour:whiteColour,isUp:false,isVisible:false});
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
