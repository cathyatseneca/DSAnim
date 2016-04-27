var anim=Animation({height:500,width:800});
var aa;
var indicator1;
var indicator2;
var msgs;
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
    msg = AnimatedText({x:200,y:250,colour:whiteColour,isVisible:false});
    indicator1=Indicator({array:aa,label:"a",visible:false});
    indicator2=Indicator({array:aa, label:"b",visible:false});
    splitter = Splitter({array:aa,leftLabel: "left", rightLabel:"right", leftColour:RED, rightColour: GREEN});
    anim.addObject(aa);
    anim.addObject(indicator1);
    anim.addObject(indicator2);
    anim.addObject(splitter);
    anim.addObject(msg);
      anim.addStep();
    anim.addInstruction(msg,msg.changeText,{str:"aaabbbbb"})
    anim.addInstruction(msg,msg.show);

    anim.addStep();
    anim.addInstruction(aa,aa.swap,{from:1, to:2});
    anim.addInstruction(indicator1,indicator1.setIdx,{idx:1});
    anim.addInstruction(indicator2,indicator2.setIdx,{idx:2});
    anim.addInstruction(indicator2,indicator2.pointDown);
    anim.addInstruction(indicator1,indicator1.show);
    anim.addInstruction(indicator1,indicator2.show);
    anim.addInstruction(splitter,splitter.setIdx,{idx:5});
    anim.addStep();
    anim.addInstruction(aa,aa.addGap,{idx:3});
    anim.addStep();
    anim.addInstruction(aa,aa.moveLocation,{from:5,to:6})
    anim.addInstruction(indicator1,indicator1.setIdx,{idx:5});
    anim.addInstruction(indicator2,indicator2.setIdx,{idx:6});
    anim.addInstruction(splitter,splitter.setIdx,{idx:4});
    anim.addStep();
    anim.addInstruction(aa,aa.setFontColour,{idx:0,colour:RED});
    anim.addInstruction(indicator1,indicator1.setIdx,{idx:0});
    anim.addStep();
    anim.addInstruction(msg,msg.hide);
    anim.addStep();
    anim.addInstruction(msg,msg.changeText,{str:"def"});
    anim.addInstruction(msg,msg.show);
    anim.addStep();
    anim.addInstruction(aa,aa.setBGColour,{idx:0,colour:GREEN});
    anim.addStep();
    anim.addInstruction(aa,aa.setAllBGColour,{colour:BLUE});
    anim.addStep();
    anim.addInstruction(aa,aa.setAllFontColour,{colour:GREEN});
    anim.addStep();
    anim.addInstruction(aa,aa.moveFrom,{x:100,y:200,idx:5});
    anim.addStep();
    anim.addInstruction(aa,aa.moveTo,{x:100,y:200,idx:6,val:66});
    anim.addInstruction(indicator1,indicator1.setIdx,{idx:4});

    anim.addStep();
    anim.addInstruction(aa,aa.addGap,{idx:5});
    anim.addStep();
    anim.addInstruction(aa,aa.removeGap,{idx:3});
  
	anim.start();
}
function  draw(){
	anim.draw();
}