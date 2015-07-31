function drawBar(idx, value, maxHeight, yOffset,  co, sz, posX, posY){
	stroke(co);
	fill(co);
	int ystart=posY+yOffset;
	int xstart=posX+idx*sz+sz/2-10;
	value=value/99;
	rect(xstart,ystart+(maxHeight-(value*maxHeight)),20,value*maxHeight);
}
function drawArrayIndex(idx, yOffset, co, sz, posX, posY){
	stroke(co);
	fill(co);
	int ystart=posY+yOffset;
	int xstart=posX+idx*sz+sz/2;
	textAlign(CENTER);
	text(idx,xstart,ystart);
}
var AnimatedArray = function(){
	var array_ = [];
	var gap_ = [];
	
}