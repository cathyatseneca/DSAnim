var anim=Animation({height:500,width:800});
var aa;
var indicator1;
var indicator2;
var RED;
var GREEN;
var BLUE;
function setup(){
    RED= color(redColour);
    GREEN=color(greenColour);
    BLUE = color(blueColour);
	anim.setBGColour(color(0,0,255));
	createCanvas(800,500);
    aa=AnimatedArray({initial:[5,10,15,20,25,30,35,40,2,3,4,5], x:20,y:100});
    indicator1=Indicator({array:aa,label:"a",visible:false});
    indicator2=Indicator({array:aa, label:"b",visible:false});
    splitter = Splitter({array:aa,leftLabel: "left", rightLabel:"right", leftColour:RED, rightColour: GREEN});
    anim.addObject(aa);
    anim.addObject(indicator1);
    anim.addObject(indicator2);
    anim.addObject(splitter);
    anim.addStep();
    anim.addInstruction(aa,aa.swap,{from:1, to:2});
    anim.addInstruction(indicator1,indicator1.setIdx,{idx:1});
    anim.addInstruction(indicator2,indicator2.setIdx,{idx:2});
    anim.addInstruction(indicator2,indicator2.pointDown);
    anim.addInstruction(indicator1,indicator1.show);
    anim.addInstruction(indicator1,indicator2.show);
    anim.addInstruction(splitter,splitter.setIdx,{idx:5});
    anim.addStep();
    anim.addInstruction(aa,aa.addGap,{pos:3});
    anim.addStep();
    anim.addInstruction(aa,aa.moveLocation,{from:5,to:6})
    anim.addInstruction(indicator1,indicator1.setIdx,{idx:5});
    anim.addInstruction(indicator2,indicator2.setIdx,{idx:6});
    anim.addInstruction(splitter,splitter.setIdx,{idx:4});
    anim.addStep();
    anim.addInstruction(aa,aa.setFontColour,{idx:0,r:255,g:0,b:0});
    anim.addInstruction(indicator1,indicator1.setIdx,{idx:0});
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
    anim.addInstruction(indicator1,indicator1.setIdx,{idx:4});

    anim.addStep();
    anim.addInstruction(aa,aa.addGap,{pos:5});
    anim.addStep();
    anim.addInstruction(aa,aa.removeGap,{pos:3});

	anim.start();
}
function  draw(){
	anim.draw();
}