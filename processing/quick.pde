
Animation anim;
AnimatedArray arr;
Indicator iIndicator;
Indicator jIndicator;
Indicator pivotIndicator;
AnimatedCode code;
 
void QuickSort(int arr[], int left, int right){
    if(left<right){
        int pivotpt=int((left+right)/2);
        int pivot=arr[pivotpt];
        anim.addStep();
        anim.addInstruction(3,SETVISIBILITY,VISIBLE);
        anim.addInstruction(3,SET,pivotpt);
        anim.addInstruction(4,SET,4);
        int i=left;
        int j=right-1;
        int tmp;
        anim.addStep();
        anim.addInstruction(0,SWAP,pivotpt,right);
        anim.addInstruction(4,SET,8);
        tmp=arr[pivotpt];
        arr[pivotpt]=arr[right];
        arr[right]=tmp;

        pivotpt=right;

        anim.addStep();
        anim.addInstruction(1,SETVISIBILITY,VISIBLE);
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);


        anim.addStep();
        anim.addInstruction(1,SET,i);
        anim.addInstruction(2,SET,j);
        anim.addInstruction(3,SET,pivotpt);
        anim.addInstruction(4,SET,9);
 
        while(i<j){
            while(i<right-1 && arr[i]<pivot){
                anim.addStep();
                anim.addInstruction(4,SET,11);
                i++;
                anim.addStep();
                anim.addInstruction(1,SET,i);
                anim.addInstruction(4,SET,12);
            } 
            while(j > 0 && arr[j]>pivot){
                anim.addStep();
                anim.addInstruction(4,SET,13);
                j--;
                anim.addStep();
                anim.addInstruction(2,SET,j);
                anim.addInstruction(4,SET,14);
            }
            if(i<j){
                anim.addStep();
                anim.addInstruction(4,SET,15);
                tmp=arr[i];
                arr[i]=arr[j];
                arr[j]=tmp;
                anim.addStep();
                anim.addInstruction(0,SWAP,i,j);
                anim.addInstruction(4,SET,16);
            }
        }
        anim.addStep();
        anim.addInstruction(4,SET,18);
        if(i==j && arr[i] < arr[pivotpt]){
            i++;
            anim.addStep();
            anim.addInstruction(1,SET,i);
            anim.addInstruction(4,SET,19);
        }
        tmp=arr[i];
        arr[i]=arr[pivotpt];
        arr[pivotpt]=tmp;
        anim.addStep();
        anim.addInstruction(4,SET,20);
        if(i!=pivotpt){
            anim.addInstruction(0,SWAP,i,pivotpt);
        }
        anim.addStep();
        anim.addInstruction(0,SETBGCOLOUR,i,189,252,201);
        anim.addInstruction(0,SETFONTCOLOURINRANGE,i,right,127,127,127);
        anim.addInstruction(4,SET,21);
        anim.addInstruction(1,SETVISIBILITY,HIDDEN);
        anim.addInstruction(2,SETVISIBILITY,HIDDEN);
        anim.addInstruction(3,SETVISIBILITY,HIDDEN);
        anim.addStep();
        anim.addInstruction(0,ADDGAP,i-1);
        anim.addInstruction(1,ADDGAP,i-1);
        anim.addInstruction(2,ADDGAP,i-1);
        anim.addInstruction(3,ADDGAP,i-1);
        QuickSort(arr,left,i-1);
        anim.addStep();
        anim.addInstruction(0,REMOVEGAP,i-1);
        anim.addInstruction(1,REMOVEGAP,i-1);
        anim.addInstruction(2,REMOVEGAP,i-1);
        anim.addInstruction(3,REMOVEGAP,i-1);
        anim.addStep();
        anim.addInstruction(0,SETFONTCOLOURINRANGE,left,i,127,127,127);
        anim.addInstruction(0,SETFONTCOLOURINRANGE,i+1,right,0,0,255);
        anim.addInstruction(4,SET,22);
        anim.addStep();
        anim.addInstruction(0,ADDGAP,i);
        anim.addInstruction(1,ADDGAP,i);
        anim.addInstruction(2,ADDGAP,i);
        anim.addInstruction(3,ADDGAP,i);
        QuickSort(arr,i+1,right);
        anim.addStep();
        anim.addInstruction(0,REMOVEGAP,i);
        anim.addInstruction(1,REMOVEGAP,i);
        anim.addInstruction(2,REMOVEGAP,i);
        anim.addInstruction(3,REMOVEGAP,i);
    }
    anim.addStep();
    anim.addInstruction(0,SETBGCOLOURINRANGE,left,right,189,252,201);
}
 

void quickSort(int arr[],int size){
  QuickSort(arr,0,size-1);
  anim.addStep();
  anim.addInstruction(0,SETALLBGCOLOUR,255,255,255);
  anim.addInstruction(0,SETALLFONTCOLOUR,0,0,255);
  anim.addInstruction(1,SETVISIBILITY,HIDDEN);
  anim.addInstruction(2,SETVISIBILITY,HIDDEN);
  anim.addInstruction(3,SETVISIBILITY,HIDDEN);
  anim.addStep();
  anim.addInstruction(4,SET,0);
}
void setSortCode(){
    int i;
    String [] s={
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
    };
    for(i=0;i<27;i++){
        code.append(s[i]);
    }
}
void setup(){
    size(900,500);
    anim=new Animation(900, 500);
//    anim.setColour(color(46,129,215));
    anim.setColour(blackColour);
    int [] array=new int[15];
    for(int i=0;i<15;i++){
        array[i]=int(random(1,99));
    }
    arr=new AnimatedArray(array,15,15,230);
    arr.hasBars_=true;
    arr.setBarOffset(-130);
    iIndicator = new Indicator("i",color(189,252,201),30,30,260);
    jIndicator = new Indicator("j",color(189,252,201),30,30,260);
    pivotIndicator=new Indicator("pivot",whiteColour,30,30,230);
    pivotIndicator.pointDown();
    code=new AnimatedCode(580,50);
    code.setWidth(310);
    setSortCode();
    int tmp;

    anim.addObject(arr);
    anim.addObject(iIndicator);
    anim.addObject(jIndicator);
    anim.addObject(pivotIndicator);
    anim.addObject(code);
    quickSort(array,15);
/*    for(int i=0;i<20;i++){
      println(array[i]);
    }*/
    anim.start();
}
void draw(){
    anim.draw();
}


