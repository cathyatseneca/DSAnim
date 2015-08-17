var anim=Animation({height:500,width:800});
var aa;
function setup(){
	anim.setBGColour(color(0,0,255));
	createCanvas(800,500);
    aa=AnimatedArray({initial:[5,10,15,20,25,30,35,40,2,3,4,5], x:10,y:10});
    anim.addObject(aa);
    anim.addStep();
    anim.addInstruction(aa,aa.swap,{from:1, to:2})
    anim.addStep();
    anim.addInstruction(aa,aa.moveLocation,{from:5,to:6})
    anim.addStep();
    anim.addInstruction(aa,aa.setFontColour,{idx:0,r:255,g:0,b:0});
    anim.addStep();
    anim.addInstruction(aa,aa.setBGColour,{idx:0,r:0,g:255,b:0});
    anim.addStep();
    anim.addInstruction(aa,aa.setAllBGColour,{r:255,g:255,b:0});
    anim.addStep();
    anim.addInstruction(aa,aa.setAllFontColour,{r:0,g:255,b:0});
    anim.addStep();
    anim.addInstruction(aa,aa.moveFrom,{x:100,y:200,idx:5});
    anim.addStep();
    anim.addInstruction(aa,aa.moveTo,{x:100,y:200,idx:6,val:66});
	anim.start();
}
function  draw(){
	anim.draw();
}