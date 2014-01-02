
Animation insertionSort;
AnimatedCode code;
Splitter split;
AnimatedArray arr;
Indicator jIndicator;
AnimatedVariable animatedVar;

void insertion(int arr[],int size){
    int curr;
    int i,j;
    for(i=0;i<size;i++){
        insertionSort.addStep();
        insertionSort.addInstruction(0,SET,4);
        curr=arr[i];
        insertionSort.addStep();
        insertionSort.addInstruction(0,SET,5);
        insertionSort.addInstruction(2,SET,i+1);
        insertionSort.addInstruction(4,MOVEFROM,i,30,315);
        insertionSort.addStep();
        insertionSort.addInstruction(1,SET,curr);
        insertionSort.addInstruction(1,SETEMPTY,0);
        insertionSort.addInstruction(3,SET,i);
        for(j=i;j>0 && arr[j-1] > curr;j--){
            insertionSort.addStep();
            insertionSort.addInstruction(0,SET,6);
            insertionSort.addInstruction(3,SET,j);

            arr[j]=arr[j-1];
            insertionSort.addStep();
            insertionSort.addInstruction(4,MOVE,j-1,j);
            insertionSort.addInstruction(0,SET,7);
        }

        arr[j]=curr;
        insertionSort.addStep();
        insertionSort.addInstruction(1,SETEMPTY,1);
        insertionSort.addInstruction(0,SET,9);
        insertionSort.addInstruction(4,MOVETO,curr,j,30,315);
    }
    insertionSort.addStep();
    insertionSort.addInstruction(0,SET,0);
    insertionSort.addInstruction(3,SETVISIBILITY,HIDDEN);
}
void setup(){
    size(800,500);
    insertionSort=new Animation(800, 500);
    code=new AnimatedCode("insertion.txt", 480,100);
    insertionSort.setColour(color(46,129,215));
    int [] array=new int[15];
    for(int i=0;i<15;i++){
        array[i]=int(random(1,99));
    }
    arr=new AnimatedArray(array,15,15,250);
    arr.hasBars_=true;
    arr.setBarOffset(-120);
    split=new Splitter("sorted","unsorted",color(0,255,0),color(255,0,0),15,30,15,85);
    jIndicator = new Indicator("",color(255,255,255),30,30,250);
    jIndicator.pointDown();
    jIndicator.setColour(color(189,252,201));
    animatedVar=new AnimatedVariable(0,30,15,300);


    int tmp;
    insertionSort.addObject(code);
    insertionSort.addObject(animatedVar);
    insertionSort.addObject(split);
    insertionSort.addObject(jIndicator);
    insertionSort.addObject(arr);
    insertion(array,15);
    insertionSort.start();
}
void draw(){
    insertionSort.draw();
}


