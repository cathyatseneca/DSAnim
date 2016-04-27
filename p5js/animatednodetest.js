var anim=Animation({height:500,width:800});
var node;
var node2;
var list;
function setup(){
	createCanvas(800,500);
	anim.setBGColour(color(0,0,0));
	node=AnimatedNode({data:"5",x:300,y:200});
	node2=AnimatedNode({data:"50",x:400,y:200});
	//p=new Pointer("ptr",200,100);
	//p.setPtr(node);
//	var labels=["first","last"];
//	list = new ListNode(labels,3,100,200);

	anim.addObject(node);
	anim.addObject(node2);
//	anim.addObject(list);
//	anim.addObject(p);
	anim.addStep();
	anim.addInstruction(node2,node2.changeNext,{next_:node});
	anim.addStep();
	anim.addInstruction(node,node.changeNext,{next_:node2});
/*	anim.addStep();
	anim.addInstruction(node2,node2.move,{dx:200,dy:0});
	anim.addStep();
	anim.addInstruction(node,node.move,{dx:-200,dy:0});*/
	anim.addStep();
	anim.addInstruction(node2,node2.removeNode);
	anim.addStep();
	anim.addInstruction(node,node.breakNext);


	anim.addStep();
	anim.addInstruction(node2,node2.move,{dx:200,dy:200});

	anim.start();
}
function draw(){
	anim.draw();
}