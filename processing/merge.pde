
Animation anim;
AnimatedArray array;
AnimatedArray array2;
Indicator aIndicator;
Indicator bIndicator;
Indicator idxIndicator;
AnimatedCode sortCode;
AnimatedCode mergeCode;

void MergeSort(int arr[],int tmp[],int start,int end){

  if(start<end){
    int mid=int((start+end)/2);
    anim.addStep();
    anim.addInstruction(0,ADDGAP,mid);
    anim.addInstruction(2,ADDGAP,mid);
    anim.addInstruction(3,ADDGAP,mid);
    anim.addInstruction(0,SETFONTCOLOURINRANGE,mid+1,end,127,127,127);
    anim.addInstruction(5,SET,11);
    MergeSort(arr,tmp,start,mid);
    anim.addStep();
    anim.addInstruction(0,SETFONTCOLOURINRANGE,mid+1,end,0,0,255);
    anim.addInstruction(0,SETFONTCOLOURINRANGE,start,mid,127,127,127);
    anim.addInstruction(5,SET,12);
    MergeSort(arr,tmp,mid+1,end);
    anim.addStep();
    anim.addInstruction(0,SETFONTCOLOURINRANGE,start,mid,0,0,255);
    anim.addInstruction(5,SET,13);
    anim.addStep();
    anim.addInstruction(5,SETVISIBILITY,HIDDEN);
    anim.addInstruction(6,SETVISIBILITY,VISIBLE);
    Merge(arr,tmp,start,mid+1,end);
    anim.addStep();
    anim.addInstruction(5,SETVISIBILITY,VISIBLE);
    anim.addInstruction(6,SETVISIBILITY,HIDDEN);
  }
  anim.addStep();
  anim.addInstruction(0,SETBGCOLOURINRANGE,start,end,189,252,201);
}

void Merge(int arr[],int tmp[],int startA,int startB,int endB){
  int aptr=startA;
  int bptr=startB;
  int idx=startA;
  anim.addStep();
  anim.addInstruction(2,SET,aptr);
  anim.addInstruction(3,SET,bptr);
  anim.addInstruction(4,SET,startA);
  anim.addStep();
  anim.addInstruction(2,SETVISIBILITY,VISIBLE);
  anim.addInstruction(3,SETVISIBILITY,VISIBLE);
  anim.addInstruction(4,SETVISIBILITY,VISIBLE);
  anim.addInstruction(6,SET,6);

  while(aptr < startB && bptr < endB+1){
    anim.addStep();
    anim.addInstruction(6,SET,7);
    if(arr[aptr] < arr[bptr]){
      anim.addStep();
      anim.addInstruction(0,SETFONTCOLOUR,aptr,0,255,0);
      anim.addInstruction(0,SETFONTCOLOUR,bptr,255,0,0);
      anim.addInstruction(6,SET,8);
      tmp[idx]=arr[aptr];
      anim.addStep();
      anim.addInstruction(0,MOVEFROM,aptr,30+idx*30,215);
      anim.addStep();
      anim.addInstruction(1,SET,idx,arr[aptr]);
      anim.addInstruction(1,SETFILLED,idx);
      anim.addInstruction(0,SETFONTCOLOUR,aptr,0,0,255);
      anim.addInstruction(0,SETFONTCOLOUR,bptr,0,0,255);
      idx++;
      aptr++;
      anim.addStep();
      if(aptr < startB){ 
        anim.addInstruction(2,SET,aptr);
      }
      else{
        anim.addInstruction(2,SETVISIBILITY,HIDDEN);
      }
      anim.addInstruction(4,SET,idx);
    }
    else{
      anim.addStep();
      anim.addInstruction(0,SETFONTCOLOUR,aptr,255,0,0);
      anim.addInstruction(0,SETFONTCOLOUR,bptr,0,255,0);
      anim.addInstruction(6,SET,11);
      tmp[idx]=arr[bptr];
      anim.addStep();
      anim.addInstruction(0,MOVEFROM,bptr,30+idx*30,215);
      anim.addStep();
      anim.addInstruction(1,SET,idx,arr[bptr]);
      anim.addInstruction(1,SETFILLED,idx);
      anim.addInstruction(0,SETFONTCOLOUR,aptr,0,0,255);
      anim.addInstruction(0,SETFONTCOLOUR,bptr,0,0,255);
      idx++;
      bptr++;
      anim.addStep();
      if(bptr < endB+1){ 
        anim.addInstruction(3,SET,bptr);
      }
      else{
        anim.addInstruction(3,SETVISIBILITY,HIDDEN);
      }
      anim.addInstruction(4,SET,idx);

      }
  }
  anim.addStep();
  anim.addInstruction(6,SET,14);
  while(aptr<startB){
    tmp[idx]=arr[aptr];
    anim.addStep();
    anim.addInstruction(0,MOVEFROM,aptr,30+idx*30,215);
    anim.addInstruction(6,SET,15);
    anim.addStep();
    anim.addInstruction(1,SET,idx,arr[aptr]);
    anim.addInstruction(1,SETFILLED,idx);
    idx++;
    aptr++;
    anim.addStep();
    if(aptr < startB){ 
      anim.addInstruction(2,SET,aptr);
    }
    else{
      anim.addInstruction(2,SETVISIBILITY,HIDDEN);
    }
    anim.addInstruction(4,SET,idx);
    anim.addInstruction(6,SET,14);
  }
  anim.addStep();
  anim.addInstruction(6,SET,17);
  while(bptr < endB+1){
    tmp[idx]=arr[bptr];
    anim.addStep();
    anim.addInstruction(0,MOVEFROM,bptr,30+idx*30,215);
    anim.addInstruction(6,SET,18);
    anim.addStep();
    anim.addInstruction(1,SET,idx,arr[bptr]);
    anim.addInstruction(1,SETFILLED,idx);
    idx++;
    bptr++;
    anim.addStep();
    if(bptr < endB+1){ 
      anim.addInstruction(3,SET,bptr);
    }
    else{
      anim.addInstruction(3,SETVISIBILITY,HIDDEN);
    }
    anim.addInstruction(4,SET,idx);
    anim.addInstruction(6,SET,17);
  }
  anim.addStep();
  anim.addInstruction(0,REMOVEGAP,startB-1);
  anim.addInstruction(2,REMOVEGAP,startB-1);
  anim.addInstruction(3,REMOVEGAP,startB-1);
  anim.addInstruction(4,SETVISIBILITY,HIDDEN);
  anim.addInstruction(6,SET,20);
  for(int i=startA;i<=endB;i++){
    anim.addStep();
    anim.addInstruction(0,MOVETO,tmp[i],i,30+i*30,215);
    anim.addInstruction(1,SETEMPTY,i);
    anim.addInstruction(6,SET,21);
    arr[i]=tmp[i];
    anim.addStep();
    anim.addInstruction(6,SET,20);
  }
  anim.addStep();
  anim.addInstruction(2,SETVISIBILITY,HIDDEN);
  anim.addInstruction(3,SETVISIBILITY,HIDDEN);

}
void setSortCode(){
    int i;
    String [] s={
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
    };
    for(i=0;i<23;i++){
        mergeCode.append(s[i]);
    }
    String [] s2={
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
    };
    for(i=0;i<15;i++){
      sortCode.append(s2[i]);
    }
}

void mergeSort(int arr[],int size){

  int [] tmp=new int[size];
  anim.addStep();
  anim.addInstruction(5,SET,3);
  MergeSort(arr,tmp,0,size-1);
}

void setup(){
    size(800,500);
    anim=new Animation(800, 500);

    //anim.setColour(color(46,129,215));
    anim.setColour(blackColour);
    int [] data=new int[15];
    for(int i=0;i<15;i++){
        data[i]=int(random(1,99));
    }
    array=new AnimatedArray(data,15,15,80);
    //println("there");
    array2=new AnimatedArray(15,15,200);
    //println("everywhere");
    //array2.clear();
    array.hasBars_=false;
    aIndicator = new Indicator("aptr",whiteColour,30,30,80);
    aIndicator.setColour(color(189,252,201));
    aIndicator.pointDown();
    aIndicator.hide();
    bIndicator = new Indicator("bptr",whiteColour,30,30,80);
    bIndicator.setColour(color(189,252,201));
    bIndicator.pointDown();
    bIndicator.hide();
    idxIndicator = new Indicator("idx",whiteColour,30,30,230);
    idxIndicator.setColour(color(189,252,201));
    idxIndicator.hide();
    mergeCode = new AnimatedCode(480,150);
    sortCode = new AnimatedCode(480,150);
    setSortCode();
    mergeCode.hide();
    sortCode.setHighLighter(3);
    mergeCode.setHighLighter(3);
    int tmp;
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
void draw(){
    anim.draw();
}


