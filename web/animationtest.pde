Animation anim;
void setup(){
	size(800,500);
	anim=new Animation(800, 500);
	AnimatedCode a=new AnimatedCode("bubble.txt", 480,100);
	int [] array=new int[15];
	for(int i=0;i<15;i++){
		array[i]=int(random(1,99));
	}
	AnimatedArray arr=new AnimatedArray(array,15,100,100);
	arr.hasBars_=true;
	int tmp;
	anim.addObject(a);
	anim.addObject(arr);
	for(int i=0;i<14;i++){
		anim.addStep();
		anim.addInstruction(0,SET,4);
		for(int j=0;j<14-i-1;j++){
			anim.addStep();
			anim.addInstruction(0,SET,5);
			anim.addStep();
			anim.addInstruction(0,SET,6);
			if(array[j] < array[j+1]){
				anim.addStep();
				anim.addInstruction(0,SET,7);
				anim.addInstruction(1,SWAP,j,j+1);
				tmp=array[j];
				array[j]=array[j+1];
				array[j+1]=tmp;
			}		
		}
	}

	anim.start();
}
void draw(){
	anim.draw();
}