var anim=Animation();
function setup(){
	createCanvas(800,500);
	var anim=Animation({height:500,width:800});
	var src=[
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
	anim.addObject(a);
	for(var i=0;i<14;i++){
		anim.addStep();
		anim.addInstruction({objecID:0,instruction:"setHighLighter",params:{ln:1}});
		for(var j=0;j<14-i-1;j++){
		anim.addInstruction({objecID:0,instruction:"setHighLighter",params:{ln:5}});
			anim.addStep();
			anim.addInstruction({objecID:0,instruction:"setHighLighter",params:{ln:6}});
			if(array[j] < array[j+1]){
				anim.addStep();
				anim.addInstruction({objecID:0,instruction:"setHighLighter",params:{ln:7}});
				tmp=array[j];
				array[j]=array[j+1];
				array[j+1]=tmp;
			}		
		}
	}

	anim.start();
}
function  draw(){
	anim.draw();
}