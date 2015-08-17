var anim=Animation({height:500,width:800});
var src;
function setup(){
	anim.setBGColour(color(0,0,255));
	createCanvas(800,500);
	src=[
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
    ];
    var array=[1,2,3,4,5,6,8,7,15,14,13,12,11,9];
	var a=AnimatedCode({code:src,x:100,y:100});
	a.setBGColour(color(255,255,255));
	a.setHighLighterColour(color(0,255,0));
	a.setFontColour(color(0,0,0));
	anim.addObject(a);
	anim.addStep();
	anim.addInstruction(a,a.setHighLighter,{ln:1});
	anim.addStep();
	anim.addInstruction(a,a.setHighLighter,{ln:2});
    anim.addStep();
    anim.addInstruction(a,a.setHighLighter,{ln:3});
    anim.addStep();
    anim.addInstruction(a,a.setHighLighter,{ln:4});
    anim.addStep();
    anim.addInstruction(a,a.setMultiHighLighter,{sln:6, eln:9});
	anim.start();
}
function  draw(){
	anim.draw();
}