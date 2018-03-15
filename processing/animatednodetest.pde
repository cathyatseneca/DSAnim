Animation anim;
AnimatedNode node;
AnimatedNode node2;
AnimationNode list;
Pointer p;
void setup(){
	size(800,500);


	anim=new Animation(800,500);
	anim.setColour(backgroundColour)
	node=new DNode(5,300,200);
	node2=new DNode(50,400,200);
	p=new Pointer("ptr",200,100);
	p.setPtr(node);
	String [] labels=new String[3];
	labels[0]="curr";
	labels[1]="first";
	labels[2]="last";
	list = new ListNode(labels,3,100,200);

	anim.addObject(node);
	anim.addObject(node2);
	anim.addObject(list);
	anim.addObject(p);
	anim.addStep();
	anim.addNodeInstruction(3,CHANGENEXT,node2);
	anim.addStep();
	anim.addNodeInstruction(2,CHANGENEXT,node,0);
	anim.addStep();
	anim.addNodeInstruction(2,CHANGENEXT,node,1);
	anim.addStep();
	anim.addNodeInstruction(2,CHANGENEXT,node2,2);
	anim.addStep();
	anim.addInstruction(2,BREAKNEXT,0);
	anim.addStep();
	anim.addInstruction(2,BREAKNEXT,1);
	anim.addStep();
	anim.addInstruction(2,BREAKNEXT,2);
	anim.addStep();
	anim.addNodeInstruction(1,CHANGENEXT,node);
	anim.addStep();
	anim.addNodeInstruction(0,CHANGENEXT,node2);
	anim.addStep();
	anim.addInstruction(1,MOVELOCATION,300,200);
	anim.addInstruction(0,MOVELOCATION,200,200);
	anim.addStep();
	anim.addInstruction(0,REMOVENODE);

//	anim.addStep();
//	anim.addInstruction(0,BREAKPREV);
	anim.addStep();
	anim.addInstruction(1,MOVELOCATION,300,300);

	anim.start();
}
void draw(){
	anim.draw();
}