
Animation bubbleSort;
AnimatedCode code;
Splitter split;
AnimatedArray arr;
Indicator jIndicator;
Indicator jPlusIndicator;

void bubble(int array[],int sz){
    int i,j;
    int tmp;
    for(i=0;i<sz-1;i++){
        bubbleSort.addStep();
        bubbleSort.addInstruction(0,SET,4);
        for(j=0;j<sz-i-1;j++){
            bubbleSort.addStep();
            bubbleSort.addInstruction(0,SET,5);
            bubbleSort.addInstruction(3,SET,j);
            bubbleSort.addInstruction(4,SET,j+1);
            bubbleSort.addStep();
            bubbleSort.addInstruction(0,SET,6);
            if(array[j] > array[j+1]){
                bubbleSort.addStep();
                bubbleSort.addInstruction(1,SETFONTCOLOUR,j,255,0,0);
                bubbleSort.addInstruction(1,SETFONTCOLOUR,j+1,255,0,0);
                bubbleSort.addStep();
                bubbleSort.addInstruction(0,SET,7);
                bubbleSort.addInstruction(1,SWAP,j,j+1);
                tmp=array[j];
                array[j]=array[j+1];
                array[j+1]=tmp;
                bubbleSort.addStep();
                bubbleSort.addInstruction(1,SETFONTCOLOUR,j,0,0,0);
                bubbleSort.addInstruction(1,SETFONTCOLOUR,j+1,0,0,0);
            }
        }
        bubbleSort.addStep();
        bubbleSort.addInstruction(2,SET,15-(i+1));
    }
    bubbleSort.addStep();
    bubbleSort.addInstruction(2,SET,0);
    bubbleSort.addInstruction(0,SET,0);
}
void setup(){
    size(800,500);
    bubbleSort=new Animation(800, 500);
    code=new AnimatedCode("bubble.txt", 480,100);
    bubbleSort.setColour(color(46,129,215));
    int [] array=new int[15];
    for(int i=0;i<15;i++){
        array[i]=int(random(1,99));
    }
    arr=new AnimatedArray(array,15,15,100);
    arr.hasBars_=true;
    arr.setBarOffset(70);
    split=new Splitter("unsorted","sorted",color(255,0,0),color(0,255,0),15,30,15,50);
    jIndicator = new Indicator("j",color(255,255,255),30,30,90);
    jPlusIndicator = new Indicator("j+1",color(255,255,255),30,30,140);
    jPlusIndicator.setPosition(1);
    jIndicator.pointDown();
    split.setPosition(15);
    int tmp;
    bubbleSort.addObject(code);
    bubbleSort.addObject(arr);
    bubbleSort.addObject(split);
    bubbleSort.addObject(jIndicator);
    bubbleSort.addObject(jPlusIndicator);
    bubble(array,15);
    bubbleSort.start();
}
void draw(){
    bubbleSort.draw();

}


