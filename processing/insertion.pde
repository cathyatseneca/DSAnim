
Animation anim;
AnimatedCode code;
Splitter split;
AnimatedArray arr;
Indicator jIndicator;
AnimatedVariable animatedVar;

void insertion(int arr[],int size){
    int curr;
    int i,j;
    anim.addStep();
    anim.addInstruction(4,SETBGCOLOUR,0,189,252,201);
    for(i=0;i<size;i++){
        anim.addStep();
        anim.addInstruction(0,SET,4);
        curr=arr[i];
        anim.addStep();
        anim.addInstruction(0,SET,5);
        anim.addInstruction(2,SET,i+1);
        anim.addInstruction(4,MOVEFROM,i,30,315);
        anim.addStep();
        anim.addInstruction(1,SET,curr);
        anim.addInstruction(1,SETEMPTY,0);
        anim.addInstruction(3,SETVISIBILITY,VISIBLE);
        anim.addInstruction(3,SET,i);
        for(j=i;j>0 && arr[j-1] > curr;j--){
            anim.addStep();
            anim.addInstruction(0,SET,6);
            anim.addInstruction(3,SET,j);

            arr[j]=arr[j-1];
            anim.addStep();
            anim.addInstruction(4,MOVELOCATION,j-1,j);
            anim.addInstruction(0,SET,7);
        }

        arr[j]=curr;
        anim.addStep();
        anim.addInstruction(3,SETVISIBILITY,HIDDEN);
        anim.addInstruction(1,SETEMPTY,1);
        anim.addInstruction(0,SET,9);
        anim.addInstruction(4,SETBGCOLOUR,i,189,252,201);
        anim.addInstruction(4,MOVETO,curr,j,30,315);
    }
    anim.addStep();
    anim.addInstruction(0,SET,0);
    anim.addInstruction(3,SETVISIBILITY,HIDDEN);
}
void setSortCode(){
    int i;
    String [] s={
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
    };
    for(i=0;i<11;i++){
        code.append(s[i]);
    }
}
void setup(){
    size(800,400);
    anim=new Animation(800, 400);
    code=new AnimatedCode(480,100);
    setSortCode();
//    anim.setColour(color(46,129,215));
    anim.setColour(backgroundColour);
    int [] array=new int[15];
    for(int i=0;i<15;i++){
        array[i]=int(random(1,99));
    }
    arr=new AnimatedArray(array,15,15,250);
    arr.hasBars_=true;
    arr.setBarOffset(-120);
    split=new Splitter("sorted","unsorted",greenColour,redColour,15,30,15,85);
    jIndicator = new Indicator("",whiteColour,30,30,250);
    jIndicator.pointDown();
    jIndicator.setColour(color(189,252,201));
    animatedVar=new AnimatedVariable(0,30,15,300);


    int tmp;
    anim.addObject(code);
    anim.addObject(animatedVar);
    anim.addObject(split);
    anim.addObject(jIndicator);
    anim.addObject(arr);
    insertion(array,15);
    anim.start();
}
void draw(){
    anim.draw();
}


