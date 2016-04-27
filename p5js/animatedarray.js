function drawBar(idx, value, maxHeight, yOffset,  co, sz, posX, posY){
	stroke(co);
	fill(co);
	var ystart=posY+yOffset;
	var xstart=posX+idx*sz+sz/2-10;
	value=value/99;
	rect(xstart,ystart+(maxHeight-(value*maxHeight)),20,value*maxHeight);
}
function drawArrayIndex(idx, yOffset, co, sz, posX, posY){
	stroke(co);
	fill(co);
	var ystart=posY+yOffset;
	var xstart=posX+idx*sz+sz/2;
	textAlign(CENTER);
	text(idx,xstart,ystart);
}
var AnimatedArray = function(spec){
	var that = AnimationObject(spec);
	var initial_ = spec.initial || [];
	var data_ = [];
	var isEmpty_ = [];
	var dataColours_ = [];
	var squareColours_ = [];
	var gap_ = [];
	var state_ = STABLE;
	var cap_ = spec.cap || 15 ;
	var sqsz_ = spec.sqsz|| 30;
	var from_ = 0;
	var to_ = 0;
	var stateStartTime_ = 0;
	var animationDuration_ = spec.animationDuration || 500;
	var hasBars_ = spec.hasBars || false;
	var barOffset_ = spec.barOffset || 80;
	var ai_;
	var maxHeight_=100;
	var moveX_ = 0;
	var moveY_ = 0;
	var moveIdx_ = 0;
	var moveVal_ = 0;
	var emptyInit_ = false;
	var showIndex_ = false;
	var empty=false;

	if(initial_.length ==0){
		for(var i = 0 ;i< cap_;i++){
			initial_.push(0);
		}
		empty=true;
	}
	else{
		cap_=initial_.length;
	}
	for (var i=0;i<cap_;i++){
		data_.push(initial_[i]);
		gap_.push(0);
		dataColours_.push(color(blueColour));
		squareColours_.push(color(255));
		isEmpty_.push(false);
	}
	that.changeSpeed = function(speed){
		animationDuration_ = 100 * speed;
	}
	that.gap = function(idx){
		return gap_[idx];
	}
	that.sqsz = function(){
		return sqsz_;
	}
	that.cap = function(){
		return cap_;
	}
	that.setShowIndex = function(visibility){
		showIndex_=visibility;
	}
	that.restart = function(){
		state_=STABLE;
		for(var i=0;i<cap_;i++){
			data_[i]=initial_[i];
			gap_[i]=0;
			dataColours_[i]=color(blueColour);
			squareColours_[i]=color(255);
			isEmpty_[i]=false;
		}
		maxHeight_=100;
		moveX_=moveY_=moveIdx_=moveVal_=0;
		stateStartTime_=millis();
	}
	that.swap = function(params){
		state_=SWAP;
		from_=params.from;
		to_=params.to;
		stateStartTime_=millis();
	}
	that.moveLocation = function(params){
		state_=MOVELOCATION;
		from_=params.from;
		to_=params.to;
		stateStartTime_=millis();		
	}
	that.setFontColour = function (params){
		ai_.setCompleted(true);
		dataColours_[params.idx]=params.colour;
	}
	that.setBGColour = function(params){
		ai_.setCompleted(true);
		squareColours_[params.idx]=params.colour;		
	}
	that.setAllBGColour = function(params){
		ai_.setCompleted(true);
		for(var i=0;i<cap_;i++){
			squareColours_[i]=params.colour;
		}
	}
	that.setAllFontColour = function(params){
		ai_.setCompleted(true);
		for(var i=0;i<cap_;i++){
			dataColours_[i]=params.colour;
		}		
	}
	that.moveFrom = function(params){
		state_=MOVEFROM;
		moveIdx_=params.idx;
		moveX_=params.x;
		moveY_=params.y;
		stateStartTime_=millis();
		isEmpty_[moveIdx_]=true;

	}
	that.moveTo = function(params){
		state_=MOVETO;
		moveVal_=params.val;
		moveIdx_=params.idx;
		moveX_=params.x;
		moveY_=params.y;
		stateStartTime_=millis();
	}
	that.addGap = function (params){
		for(var i=params.idx;i<cap_-1;i++){
			gap_[i+1]+=(sqsz_/2);
		}
		ai_.setCompleted(true);
	}
	that.removeGap = function(params){
		for(var i=params.idx;i<cap_-1;i++){
			gap_[i+1]-=(sqsz_/2);
		}
		ai_.setCompleted(true);		
	}
	that.setFontColourInRange = function(params){
		ai_.setCompleted(true);
		for(var i=params.from;i<=params.to;i++){
			dataColours_[i]=params.colour;
		}
	}
	that.setBGColourInRange = function(params){
		ai_.setCompleted(true);
		for(var i=params.from;i<=params.to;i++){
			squareColours_[i]=params.colour;
		}	
	}
	that.setEmpty = function(params){
		ai_.setCompleted(true);
		isEmpty_[params.idx]=true;

	}
	that.setFilled = function(params){
		ai_.setCompleted(true);
		isEmpty_[params.idx]=false;		
	}
	that.set = function(params){
		ai_.setCompleted(true);
		data_[params.idx]=params.val;
	}
	that.process = function(ai){
		ai_=ai;
		ai.instruction();
	}
	that.clear = function(){
		for(var i=0;i<cap_;i++){
			isEmpty_[i]=true;
		}
	}
	that.drawMoveFrom = function(){
		that.drawStable();
		var currTime=millis();
		if(currTime - stateStartTime_ < animationDuration_){
			var startX=((gap_[moveIdx_]+that.getX()+moveIdx_*sqsz_)+(0.5*sqsz_));
			var startY=that.getY()+sqsz_*0.5+5;
			var len=dist(0,0,startX,startY);
			var vX=(startX-moveX_)/len*10;
			var vY=(startY-moveY_)/len*10;
			var t=(currTime-stateStartTime_)/animationDuration_;
			var cpX=(startX+moveX_)/2-vY;
			var cpY=(startY+moveY_)/2+vX;
		    var x=bezierPoint(startX,cpX,cpX,moveX_,t);
		    var y=bezierPoint(startY,cpY,cpY,moveY_,t);
		    fill(dataColours_[moveIdx_]);
		    text(data_[moveIdx_],x,y);
		}
		else{
			ai_.setCompleted(true);
	    	state_=STABLE;

		}
	}
	that.drawMoveTo = function(){
		that.drawStable();
		var currTime=millis();
		if(currTime - stateStartTime_ < animationDuration_){

			var startX=((gap_[moveIdx_]+that.getX()+moveIdx_*sqsz_)+(0.5*sqsz_));
			var startY=that.getY()+sqsz_*0.5+5;
			var len=dist(0,0,startX,startY);
			var vX=(startX-moveX_)/len*10;
			var vY=(startY-moveY_)/len*10;
			var t=(currTime-stateStartTime_)/animationDuration_;
			var cpX=(startX+moveX_)/2-vY;
			var cpY=(startY+moveY_)/2+vX;
		    var x=bezierPoint(moveX_,cpX,cpX,startX,t);
		    var y=bezierPoint(moveY_,cpY,cpY,startY,t);
		    fill(dataColours_[moveIdx_]);
		    text(moveVal_,x,y);		}
		else{
			data_[moveIdx_]=moveVal_;
			isEmpty_[moveIdx_]=false;
			ai_.setCompleted(true);
	    	state_=STABLE;
	    	that.drawStable();
		}

	}
	that.drawBars = function(){
    	for(var i=0;i<cap_;i++){
      		if(!isEmpty_[i]){
        		drawBar(i,data_[i],maxHeight_,barOffset_,color(255,255,255),sqsz_,gap_[i]+that.getX(),that.getY());
		    }
	    }   

	}
	that.drawStable = function(){
		for(var i=0;i<cap_;i++){
			if(isEmpty_[i] != true){
				drawSqWithNum(data_[i],dataColours_[i],squareColours_[i],sqsz_,gap_[i]+that.getX()+i*sqsz_,that.getY());
			}
			else{
				drawSquare(sqsz_,squareColours_[i],gap_[i]+that.getX()+i*sqsz_,that.getY());
			}

		}

	}
	that.drawSwap = function(){
		var currTime=millis();
		var gap;
		if(currTime - stateStartTime_ < animationDuration_){
	    	for(var i=0;i<cap_;i++){
    	    	if(i==to_ || i==from_){
        	  		drawSquare(sqsz_,squareColours_[i],gap_[i]+that.getX()+i*sqsz_,that.getY());
        		}
       			else{
          			drawSqWithNum(data_[i],dataColours_[i],squareColours_[i],sqsz_,gap_[i]+that.getX()+i*sqsz_,that.getY());
        		}
	      	}
	      	var t=(currTime-stateStartTime_)/animationDuration_;
	      	var start = gap_[from_]+that.getX()+(from_+0.5)*sqsz_;
	      	var end = gap_[to_]+that.getX()+(to_+0.5)*sqsz_;
	      	var half= (start+end)/2;
	      	var height=50;
	      	var x=bezierPoint(start,half,half,end,t);
	      	var y=bezierPoint(that.getY()+(sqsz_*0.5)+5,that.getY()-height+5,that.getY()-height+5,that.getY()+(sqsz_*0.5)+5,t);
	      	fill(dataColours_[from_]);
	      	text(data_[from_],x,y);	

	      	x=bezierPoint(end,half,half,start,t);
	      	y=bezierPoint(that.getY()+(sqsz_*0.5)+5,that.getY()+height+5,that.getY()+height+5,that.getY()+(sqsz_*0.5)+5,t);
	      	fill(dataColours_[to_]);
	      	text(data_[to_],x,y);
	    }
	    else{
	    	var tmp=data_[to_];
	    	data_[to_]=data_[from_];
	    	data_[from_]=tmp;
	    	ai_.setCompleted(true);
	    	state_=STABLE;
	    	that.drawStable();
	    }
	}
	that.drawMove = function(){
		var currTime=millis();
		if(currTime - stateStartTime_ < animationDuration_){
	    	for(var i=0;i<cap_;i++){
    	    	if(i==to_ || i==from_){
        	  		drawSquare(sqsz_,squareColours_[i],gap_[i]+that.getX()+i*sqsz_,that.getY());
        		}
       			else{
          			drawSqWithNum(data_[i],dataColours_[i],squareColours_[i],sqsz_,gap_[i]+that.getX()+i*sqsz_,that.getY());
        		}
	      	}
	      	var t=(currTime-stateStartTime_)/animationDuration_;
	      	var start = gap_[from_]+that.getX()+(from_+0.5)*sqsz_;
	      	var end = gap_[to_]+that.getX()+(to_+0.5)*sqsz_;
	      	var half= (start+end)/2;
	      	var height=50;
	      	var x=bezierPoint(start,half,half,end,t);
	      	var y=bezierPoint(that.getY()+(sqsz_*0.5),that.getY()-height+9,that.getY()-height+9,that.getY()+(sqsz_*0.5)+9,t);
	      	fill(dataColours_[from_]);
	      	text(data_[from_],x,y);	

	    }
	    else{
	    	data_[to_]=data_[from_];
	    	isEmpty_[from_]=true;
	    	isEmpty_[to_]=false;
	    	ai_.setCompleted(true);
	    	state_=STABLE;
	    	that.drawStable();
	    }
	}
	that.drawIndex = function(){

    	for(var i=0;i<cap_;i++){
       		drawArrayIndex(i,sqsz_/2 + sqsz_,color(255,255,255),sqsz_,gap_[i]+that.getX(),that.getY());
	    }   

	}
	that.draw = function(){
		switch(state_){
			case STABLE:
				that.drawStable(); 
				break;
			case SWAP:
				that.drawSwap();
				break;
			case MOVETO:
				that.drawMoveTo(); 
				break;
			case MOVEFROM:
				that.drawMoveFrom();
				break;
			case MOVELOCATION:
				that.drawMove();
				break;		
		}
		if(hasBars_ == true){
			that.drawBars();
		}
		if(showIndex_ == true){
			that.drawIndex();
		}
	}
	that.fillRandom = function(){
    	for(var i=0;i<cap_;i++){
      		data_[i]=integer(random(1,99));
    	}
	}
	that.reset = function(sz){
    	for(var i=0;i<sz;i++){
      		data_[i]=array[i];
    	}
   		cap_=sz;

	}
	that.setBarOffset = function (offset){
  		barOffset_=offset;

	}
	that.changeSpeed = function (speed){
  		animationDuration_=speed*100;

	}
	return that;
}
var Indicator = function(spec){
	var that=AnimationObject(spec);
	var array_ = spec.array;
	var label_ = spec.label || "";
	var idx_ = spec.idx || 0;
	var isUp_ = spec.isUp;
	var isVisible_ = spec.isVisible;
	var initidx_= idx_;
	var colour_= spec.colour;
	if(isUp_ == undefined){
		isUp_=true;
	}
	if(isVisible_ == undefined){
		isVisible_=true;
	}
	if(colour_ == undefined){
		colour_=color(255);
	}

	that.setPosition(array_.getX(), array_.getY());
	that.restart = function(){
		idx_=initidx_;
	}
	that.setIdx = function(params){
		idx_=params.idx;
	}
	that.pointDown = function(){
		isUp_=false;
	}
	that.pointUp = function(){
		isUp_=true;
	}
	that.hide = function(){
		isVisible_=false;
	}
	that.show = function(){
		isVisible_=true;
	}
	that.process = function(ai){
		ai.instruction();
		ai.setCompleted(true);
	}
	that.draw = function(){
		var sz=array_.sqsz();
		var offset=sz/2;
		var posX = array_.gap(idx_);
		if(isVisible_){
			if(isUp_){
				drawTriangle(colour_,array_.gap(idx_)+that.getX()+idx_*sz+offset,that.getY()+sz);
				textAlign(CENTER);
				text(label_,array_.gap(idx_)+that.getX()+idx_*sz+offset,that.getY()+25+sz);
			}
			else{
				drawDownTriangle(colour_,array_.gap(idx_)+ that.getX()+idx_*sz + offset,that.getY());
				textAlign(CENTER);
				text(label_,array_.gap(idx_)+that.getX()+idx_*sz+offset,that.getY()-15);

			}
		}
	}
	return that;
}

var Splitter = function(spec){
	var that = AnimationObject(spec);
	var array_ = spec.array;
	var leftLabel_ = spec.leftLabel || "";
	var rightLabel_ = spec.rightLabel || "";
	var leftColour_ = spec.leftColour; 
	var rightColour_ = spec.rightColour;
	var idx_ = spec.idx|| 0;
	var yOffset_=spec.yOffset || 0; 
					 //normally splitter appears 60 units above top of array
	                 //when yOFFset_ is negative it moves further up, positive further down

	that.setPosition(array_.getX(),array_.getY());
	that.setIdx = function(params){
		if(params.idx >=0 && params.idx <= array_.cap()){
			idx_=params.idx;
		}
	}
	that.restart = function(){
		idx_=spec.idx || 0;
	}
	that.changeYOffset = function(params){
		yOffset_=params.yOffset;
	}
	that.process = function(ai){
		ai.instruction();
		ai.setCompleted(true);
	}
	that.draw = function(){
		var topY= that.getY()-60 + yOffset_;
		var endpt= that.getX()+(array_.sqsz()*array_.cap()) + (array_.gap(array_.cap()-1));
		var gapOffset = array_.gap(idx_>0?idx_-1:0);
		if(array_.gap(idx_) != gapOffset){
			gapOffset += array_.cap()/2;
		}
	 	var topX= that.getX()+ gapOffset +(idx_*array_.sqsz());
		fill("#FFFFFF");
		stroke("#FFFFFF");

		strokeWeight(3);
		line(topX,topY, topX, topY+30);
		strokeWeight(1);
		if(idx_ !=0){
			push();
			textAlign(LEFT);
			text(leftLabel_,that.getX(),topY);    
			fill(leftColour_);
			stroke(leftColour_);
			line(that.getX(),topY+15,topX-5,topY+15);
			triangle(that.getX(),topY+15,that.getX()+10,topY+10,that.getX()+10,topY+20);
			pop();

		}
		if(idx_!=array_.cap()){
			push();
			textAlign(RIGHT);
			text(rightLabel_,endpt,topY);    
			fill(rightColour_);
			stroke(rightColour_);
			line(topX+5,topY+15,endpt,topY+15);
			triangle(endpt,topY+15,endpt-10,topY+10,endpt-10,topY+20);
			pop();
		}		
	}
	return that;
}

var AnimatedVariable =function (spec){
	var that = AnimationObject(spec);
	var value_ = spec.value;
	var initial_ = spec.value;
	var textColour_ = spec.textColour;
	var bgColour_ = spec.bgColour;
	var size_ = spec.size || 30;
	var isEmpty_ = spec.isEmpty || true;
	if(textColour_==undefined){
		textColour_=color(0);
	}
	if(bgColour_ == undefined){
		bgColour_=color(255);
	}
	that.setEmpty = function(e){
		isEmpty_=e;
	}
	that.set = function(params){
		value_=params.value;
	}
	that.setFontColour = function(params){
		textColour_=params.colour;
	}
	that.setBGColour = function(params){
		bgColour_=params.colour;
	}
	that.setEmpty = function(){
		isEmpty_=true;
	}
	that.setFilled = function(){
		isEmpty_=false;
	}
	that.process = function(ai){
		ai.instruction();
		ai.setCompleted(true);
	}

	that.restart = function(){
		value_=initial_;
		textColour_ = spec.textColour;
		bgColour_ = spec.bgColour;
		if(textColour_==undefined){
			textColour_=color(0);
		}
		if(bgColour_ == undefined){
			bgColour_=color(255);
		}
		isEmpty_=spec.isEmpty || true;
	}
	that.draw=function(){
    	if(!isEmpty_){
    		drawSqWithNum(value_,textColour_,bgColour_,size_,that.getX(),that.getY());
	    }
    	else{
    		drawSquare(size_,bgColour_, that.getX(), that.getY());
    	}
	}
	return that;

}