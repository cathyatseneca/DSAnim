
var anim;
var array;
var array2;
var aIndicator;
var bIndicator;
var idxIndicator;
var sortCode;
var mergeCode;
var playButton;
var pauseButton;
var stepButton;
var restartButton;
var speedSlider;
function MergeSort(arr, tmp, start, end){

  if(start<end){
    var mid=int((start+end)/2);
    anim.addStep();
    anim.addInstruction(array,array.addGap,{idx:mid});
    anim.addInstruction(array,array.setFontColourInRange,{from:mid+1, to:end, colour:greyColour});
    anim.addInstruction(sortCode,sortCode.setHighLighter,{ln:11});
    MergeSort(arr,tmp,start,mid);
    anim.addStep();
    anim.addInstruction(array,array.setFontColourInRange,{from:mid+1,to:end,colour:blueColour});
    anim.addInstruction(array,array.setFontColourInRange,{from:start,to:mid,colour:greyColour});
    anim.addInstruction(sortCode,sortCode.setHighLighter,{ln:12});

    MergeSort(arr,tmp,mid+1,end);
    anim.addStep();
    anim.addInstruction(array,array.setFontColourInRange,{from:start,to:mid,colour:blueColour});
    anim.addInstruction(sortCode,sortCode.setHighLighter,{ln:13});

    anim.addStep();
    anim.addInstruction(sortCode,sortCode.hide);
    anim.addInstruction(mergeCode,mergeCode.show);

    Merge(arr,tmp,start,mid+1,end);

    anim.addStep();
    anim.addInstruction(sortCode,sortCode.show);
    anim.addInstruction(mergeCode,mergeCode.hide);
  }
  anim.addStep();
  anim.addInstruction(array,array.setBGColourInRange,{from:start,to:end,colour:mintGreenColour});

}

function Merge(arr, tmp, startA, startB, endB){
  var aptr=startA;
  var bptr=startB;
  var idx=startA;
  anim.addStep();
  anim.addInstruction(aIndicator,aIndicator.setIdx,{idx:aptr});
  anim.addInstruction(bIndicator,bIndicator.setIdx,{idx:bptr});
  anim.addInstruction(idxIndicator,idxIndicator.setIdx,{idx:startA});
  anim.addStep();
  anim.addInstruction(aIndicator,aIndicator.show);
  anim.addInstruction(bIndicator,bIndicator.show);
  anim.addInstruction(idxIndicator,idxIndicator.show);
  anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:6});


  while(aptr < startB && bptr < endB+1){
    anim.addStep();
    anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:7});
    if(arr[aptr] < arr[bptr]){
      anim.addStep();
      anim.addInstruction(array,array.setFontColour,{idx:aptr,colour:redColour});
      anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:8});

      tmp[idx]=arr[aptr];
      anim.addStep();
      anim.addInstruction(array,array.moveFrom,{idx:aptr,x:30+idx*30,y:215});
      anim.addStep();
      anim.addInstruction(array2,array2.set,{idx:idx,val:arr[aptr]});
      anim.addInstruction(array2,array2.setFilled,{idx:idx});
      anim.addInstruction(array,array.setFontColour,{idx:aptr,colour:blueColour});
      idx++;
      aptr++;
      anim.addStep();
      if(aptr < startB){ 
        anim.addInstruction(aIndicator,aIndicator.setIdx,{idx:aptr});
      }
      else{
        anim.addInstruction(aIndicator,aIndicator.hide);
      }
      anim.addInstruction(idxIndicator,idxIndicator.setIdx,{idx:idx});
    }
    else{
      anim.addStep();
      anim.addInstruction(array,array.setFontColour,{idx:bptr,colour:redColour});
      anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:11});

      tmp[idx]=arr[bptr];
      anim.addStep();
      anim.addInstruction(array,array.moveFrom,{idx:bptr,x:30+idx*30,y:215});
      anim.addStep();
      anim.addInstruction(array2,array2.set,{idx:idx,val:arr[bptr]});
      anim.addInstruction(array2,array2.setFilled,{idx:idx});

      anim.addInstruction(array,array.setFontColour,{idx:bptr,colour:blueColour});
      idx++;
      bptr++;
      anim.addStep();
      if(bptr < endB+1){ 
        anim.addInstruction(bIndicator,bIndicator.setIdx,{idx:bptr});
      }
      else{
        anim.addInstruction(bIndicator,bIndicator.hide);
      }
      anim.addInstruction(idxIndicator,idxIndicator.setIdx,{idx:idx});

    }
  }
  anim.addStep();
  anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:14});
  while(aptr<startB){
    tmp[idx]=arr[aptr];
    anim.addStep();
    anim.addInstruction(array,array.moveFrom,{idx:aptr,x:30+idx*30,y:215});
    anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:15});
    anim.addStep();
    anim.addInstruction(array2,array2.set,{idx:idx,val:arr[aptr]});
    anim.addInstruction(array2,array2.setFilled,{idx:idx});
    idx++;
    aptr++;
    anim.addStep();
    if(aptr < startB){ 
      anim.addInstruction(aIndicator,aIndicator.setIdx,{idx:aptr});
    }
    else{
      anim.addInstruction(aIndicator,aIndicator.hide);
    }
    anim.addInstruction(idxIndicator,idxIndicator.setIdx,{idx:idx});
    anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:14});
  }
  anim.addStep();
  anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:17});
  while(bptr < endB+1){
    tmp[idx]=arr[bptr];
    anim.addStep();
    anim.addInstruction(array,array.moveFrom,{idx:bptr,x:30+idx*30,y:215});
    anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:18});
    anim.addStep();
    anim.addInstruction(array2,array2.set,{idx:idx,val:arr[bptr]});
    anim.addInstruction(array2,array2.setFilled,{idx:idx});
    idx++;
    bptr++;
    anim.addStep();
    if(bptr < endB+1){ 
      anim.addInstruction(bIndicator,bIndicator.setIdx,{idx:bptr});
    }
    else{
      anim.addInstruction(bIndicator,bIndicator.hide);
    }
    anim.addInstruction(idxIndicator,idxIndicator.setIdx,{idx:idx});
    anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:17});
  }
  anim.addStep();
  anim.addInstruction(array,array.removeGap,{idx:startB-1});
  anim.addInstruction(idxIndicator,idxIndicator.hide);
  anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:20});
  for(var i=startA;i<=endB;i++){
    anim.addStep();
    anim.addInstruction(array,array.moveTo,{val:tmp[i],idx:i,x:30+i*30,y:215});
    anim.addInstruction(array2,array2.setEmpty,{idx:i});
    anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:21});
    arr[i]=tmp[i];
    anim.addStep();
    anim.addInstruction(mergeCode,mergeCode.setHighLighter,{ln:20});
  }
  anim.addStep();
  anim.addInstruction(aIndicator,aIndicator.hide);
  anim.addInstruction(bIndicator,bIndicator.hide);

}
function setSortCode(){
    var s=[
    "void Merge(int arr[],int tmp[],",
    "  int startA,int startB,int endB){",
    "  int aptr=startA;",
    "  int bptr=startB;",
    "  int idx=startA;",
    "  while(aptr < startB && bptr < endB+1){",
    "    if(arr[aptr] < arr[bptr]){",
    "      tmp[idx++]=arr[aptr++];",
    "    }",
    "    else{",
    "      tmp[idx++]=arr[bptr++];",
    "    }",
    "  }",
    "  while(aptr<startB){",
    "    tmp[idx++]=arr[aptr++];",
    "  }",
    "  while(bptr < endB+1){",
    "    tmp[idx++]=arr[bptr++];",
    "  }",
    "  for(int i=startA;i<=endB;i++){",
    "    arr[i]=tmp[i];",
    "  }",
    "}"
    ];
    mergeCode = AnimatedCode({code:s,x:550,y:30,isVisible:false});
    var s2=[
    "void MergeSort(int arr[],int size){",
    "  int* tmp=new int[size];",
    "  MSort(arr,tmp,0,size-1);",
    "  delete [] tmp;",
    "}",
    " ",
    "void mSort(int arr[],int tmp[],",
    "          int start,int end){",
    "  if(start<end){",
    "    int mid=(start+end)/2;",
    "    mSort(arr,tmp,start,mid);",
    "    mSort(arr,tmp,mid+1,end);",
    "    Merge(arr,tmp,start,mid+1,end);",
    "  }",
    "}"
    ];

    sortCode =  AnimatedCode({code:s2,x:550,y:30});
}

function mergeSort(arr, size){

  var tmp=[];
  for(var i=0;i<size;i++){
    tmp.push(int(0));
  }
  anim.addStep();
  anim.addInstruction(sortCode,sortCode.setHighLighter,{ln:3});
  MergeSort(arr,tmp,0,size-1);
  anim.addStep();
  anim.addInstruction(sortCode,sortCode.setHighLighter,{ln:0});
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
    anim=Animation({width:950, height:500});

    anim.setBGColour(blackColour);
    var data=[];
    for(var i=0;i<15;i++){
      data.push(int(random(1,99)));
    }
    array=AnimatedArray({initial:data,x:15,y:80, hasBars: false});
    array2=new AnimatedArray({x:15,y:200});

    aIndicator = Indicator({array: array, label:"aptr",colour: mintGreenColour,
                                                          isUp:false,isVisible:false});

    bIndicator = Indicator({array: array, label:"bptr",colour: mintGreenColour,
                                                          isUp:false,isVisible:false});

    idxIndicator = Indicator({array: array2, label:"idx",colour: mintGreenColour,
                                                                  isVisible:false});


    setSortCode();
 
    sortCode.setHighLighter({ln:3});
    mergeCode.setHighLighter({ln:3});
    anim.addObject(array);
    anim.addObject(array2);
    anim.addObject(aIndicator);
    anim.addObject(bIndicator);
    anim.addObject(idxIndicator);
    anim.addObject(sortCode);
    anim.addObject(mergeCode);

    mergeSort(data,15);
    anim.start();
    //anim.steps_[7].dump();
}
function draw(){
    changeSpeed(speedSlider.value());
    anim.draw();
}
