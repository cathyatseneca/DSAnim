
Animation anim;
AnimatedCode code;
AnimatedArray arr;
AnimatedArray arr2;
Indicator aIndicator;
Indicator bIndicator;
Indicator idxIndicator;

void MergeSort(int arr[],int tmp[],int start,int end){
  //if the array is more than one element big
  if(start<end){
    int mid=(start+end)/2;
    MergeSort(arr,tmp,start,mid);
    MergeSort(arr,tmp,mid+1,end);
    Merge(arr,tmp,start,mid+1,end);
  }
}

void Merge(int arr[],int tmp[],int startA,int startB,int endB){
  int aptr=startA;
  int bptr=startB;
  int idx=startA;
  while(aptr < startB && bptr < endB+1){
    if(arr[aptr] < arr[bptr]){
       tmp[idx]=arr[aptr];
       idx++;
       aptr++;
    }
    else{
       tmp[idx++]=arr[bptr];
       bptr++;
    }
  }
  while(aptr<startB){
    tmp[idx]=arr[aptr];
    idx++;
    aptr++;    
  }
  while(bptr < endB+1){
    tmp[idx++]=arr[bptr];
    bptr++;
  }
  for(int i=startA;i<=endB;i++){
    arr[i]=tmp[i];
  }
}

void MergeSort(int arr[],int size){
  anim.addStep();
  anim.addInstruction(0,SET,2);
  int* tmp=new int[size];
  MergeSort(arr,tmp,0,size-1);
  delete [] tmp;
}

void setup(){
    size(800,500);
    anim=new Animation(800, 500);
    code=new AnimatedCode("merge.txt", 480,80);
    anim.setColour(color(46,129,215));
    int [] array=new int[15];
    for(int i=0;i<15;i++){
        array[i]=int(random(1,99));
    }
    arr=new AnimatedArray(array,15,15,230);
    arr2=new AnimatedArray(array,15,15,300);
    arr.hasBars_=false;
    aIndicator = new Indicator("aptr",color(255,255,255),30,30,260);
    aIndicator.setColour(color(189,252,201));
    bIndicator = new Indicator("bptr",color(255,255,255),30,30,230);
    bIndicator.setColour(color(189,252,201));
    idxIndicator = new Indicator("idx",color(255,255,255),30,30,230);
    idxIndicator.setColour(color(189,252,201));


    int tmp;
    anim.addObject(code);
    anim.addObject(arr);
    anim.addObject(arr2);
    anim.addObject(aIndicator);
    anim.addObject(bIndicator);
    anim.addObject(idxIndicator);
    MergeSort(array,15);
    anim.start();
}
void draw(){
    anim.draw();
}


