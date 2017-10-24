
Animation anim;
AnimatedCode code;
Splitter split;
AnimatedArray arr;
Indicator jIndicator;
Indicator jPlusIndicator;

void bubble(int array[],int sz){
    int i,j;
    int tmp;
    for(i=0;i<sz-1;i++){
        anim.addStep();
        anim.addInstruction(0,SET,4);
        for(j=0;j<sz-i-1;j++){
            anim.addStep();
            anim.addInstruction(0,SET,5);
            anim.addInstruction(3,SET,j);
            anim.addInstruction(4,SET,j+1);
            anim.addStep();
            anim.addInstruction(0,SET,6);
            if(array[j] > array[j+1]){
                anim.addStep();
                anim.addInstruction(1,SETFONTCOLOUR,j,255,0,0);
                anim.addInstruction(1,SETFONTCOLOUR,j+1,255,0,0);
               // anim.addStep();
                anim.addInstruction(0,SETRANGE,7,10);
                anim.addInstruction(1,SWAP,j,j+1);
                tmp=array[j];
                array[j]=array[j+1];
                array[j+1]=tmp;
                anim.addStep();
                anim.addInstruction(1,SETFONTCOLOUR,j,0,0,255);
                anim.addInstruction(1,SETFONTCOLOUR,j+1,0,0,255);
            }
        }
        anim.addStep();
        anim.addInstruction(2,SET,sz-(i+1));
        anim.addInstruction(1,SETBGCOLOUR,sz-(i+1),189,252,201);
    }
    anim.addStep();
    anim.addInstruction(2,SET,0);
    anim.addInstruction(0,SET,0);
    anim.addInstruction(1,SETBGCOLOUR,0,189,252,201);
    anim.addInstruction(3,SETVISIBILITY,HIDDEN);
    anim.addInstruction(4,SETVISIBILITY,HIDDEN);
}
void setSortCode(){
    int i;
    String [] s={
    "void bubble(int array[],int sz){",
    "int i,j;",
    "int tmp;",
    "for(i=0;i<sz-1;i++){",
    "    for(j=0;j<sz-i-1;j++){",
    "        if(array[j] > array[j+1]){",
    "            /*swap arr[j] and arr[j+1]*/",
    "            tmp=array[j];",
    "            array[j]=array[j+1];",
    "            array[j+1]=tmp;",
    "        }",
    "    }",
    "}"
    };
    for(i=0;i<13;i++){
        code.append(s[i]);
    }
}
void setup(){
    size(800,350);
    anim=new Animation(800, 350);
    code=new AnimatedCode(480,100);
    setSortCode(code);
    //anim.setColour(color(46,129,215));
    anim.setColour(blackColour);    
    int [] array=new int[15];
    for(int i=0;i<15;i++){
        array[i]=int(random(1,99));
    }
    arr=new AnimatedArray(array,15,15,120);
    arr.hasBars_=true;
    arr.setBarOffset(70);
    split=new Splitter("unsorted","sorted",redColour,greenColour,15,30,15,50);
    jIndicator = new Indicator("j",whiteColour,30,30,120);
    jPlusIndicator = new Indicator("j+1",whiteColour,1,30,30,150);
    jIndicator.pointDown();
    split.setPosition(15);
    int tmp;
    anim.addObject(code);
    anim.addObject(arr);
    anim.addObject(split);
    anim.addObject(jIndicator);
    anim.addObject(jPlusIndicator);
    bubble(array,15);
    anim.setMode(STEP);
    anim.setState(RUNNING);
    anim.start();
}
void draw(){
    anim.draw();

}

/*void mousePressed(){
  anim.setState(RUNNING);
}*/

