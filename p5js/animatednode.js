var AnimatedNode = function(spec){
	var that=AnimationObject(spec);
	var data_ = spec.data || "";
	var next_ = null;
	var bgColour_ = color(whiteColour);
	var fontColour_ = color(blueColour);
	var nextColour_ = color(greenColour);
	var stateStartTime_ = 0;
	var animationDuration_ = spec.animationDuration || 500;
	var state_ = STABLE;
	var nodeWidth_=spec.width || 50;
	var nodeHeight_=spec.height || 50;
	var isVisible_=spec.isVisible;
	var destX_;
	var destY_;
	var startX_;
	var startY_;
	if(isVisible_==undefined){
		isVisible_=true;
	}

	that.setNext=function(next){
		next_=next;
	}
	that.changeNext =function(params){
		state_=CHANGENEXT;
		that.setNext(params.next_);
		stateStartTime_=millis();
	}
	that.breakNext=function(){
		if(next_!=null){
			state_=BREAKNEXT;
			stateStartTime_=millis();
		}
	}
	that.removeNode=function(){
		state_=REMOVENODE;
		stateStartTime_=millis();
	}
	that.show=function(){
		isVisible_=true;
	}
	that.hide=function(){
		isVisible_=false;
	}
	that.move=function(params){
		state_=MOVELOCATION;
		stateStartTime_=millis();
		destX_=that.getX()+params.dx;
		destY_=that.getY()+params.dy
		startX_=that.getX();
		startY_=that.getY();
	}
	that.moveTo=function(params){
		state_=MOVELOCATION;
		stateStartTime_=millis();
		destX_=params.destx;
		destY_=params.desty;
		startX_=that.getX();
		startY_=that.getY();
	}
	that.process=function(ai){
		ai_=ai;
		ai.instruction();
	}
	that.nodeWidth=function(){
		return nodeWidth_;
	}
	that.nodeHeight=function(){
		return nodeHeight_;
	}

	that.drawNode=function(){
		push();
		rectMode(CENTER);
		fill(bgColour_);
		stroke(0);
		rect(that.getX(),that.getY(),nodeWidth_,nodeHeight_,5,5,5,5);
		fill(fontColour_);
		stroke(fontColour_);
		textAlign(CENTER);
		text(data_,that.getX(),that.getY()-5);
		pop();
	}
	that.drawNext=function(){
		fill(nextColour_);
		stroke(nextColour_);
		ellipse(that.getX(),that.getY()+10,5,5);
		if(next_ != null){
			noFill();
			var endX=next_.getX() - (next_.nodeWidth())/2-2;
			var endY=next_.getY()+10;
			var cx1 = that.getX()+(endX-that.getX())/2;
			var cx2 = that.getX()+(endX-that.getX())/2;
			var cy1 = endY+30;
			var cy2 = endY+30;
			if(endX < that.getX()){
				cy1 = endY + 80;
				cy2 = endY + 80;
				cx1 = that.getX() + 40;
				cx2 = endX -40;
			}
			bezier(that.getX(),that.getY()+10, cx1,cy1,cx2,cy2,  endX,endY);
  			var tx = bezierTangent(that.getX(), cx1,cx2, endX, 1);
 			var ty = bezierTangent(that.getY()+10, cy1,cy2, endY, 1);
 			var a=atan2(ty,tx);
 			a+=PI/2;
			fill(nextColour_);
			push();
		  	translate(endX,endY);
			rotate(a);
  			triangle(-4,4,4,4,0,-4);
			pop(); 			
		}
	}
	that.drawStable=function(){
		that.drawNode();
		that.drawNext();
	}
	that.drawMove=function(){
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			that.setPosition(startX_+(destX_-startX_)*frame,startY_+(destY_-startY_)*frame);
		}
		else{
			that.setPosition(destX_,destY_);
			state_=STABLE;
			ai_.setCompleted(true);
		}
		that.drawStable();
	}
	that.drawChangeNext= function(){
		that.drawNode();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
		stroke(nextColour_);
		fill(nextColour_);
		ellipse(that.getX(),that.getY()+10,5,5);
		if(next_!= null && frame < 1){
			var endX=next_.getX() - (next_.nodeWidth())/2-2;
			var endY=next_.getY() +10;
			var px =bezierPoint(that.getX(), that.getX()+(endX-that.getX())/2, that.getX()+(endX-that.getX())/2, endX, 0);
			var py = bezierPoint(that.getY()+10, endY+30, endY+30, endY, 0);
			var cx,cy;
			var tx,ty;
			var a;
			var cx1 = that.getX()+(endX-that.getX())/2;
			var cx2 = that.getX()+(endX-that.getX())/2;
			var cy1 = endY+30;
			var cy2 = endY+30;
			if(endX < that.getX()){
				cy1 = endY + 80;
				cy2 = endY + 80;
				cx1 = that.getX() + 40;
				cx2 = endX -40;
			}
			for(var i=1;i<frame*1000;i++){
				cx = bezierPoint(that.getX(), cx1,cx2, endX, i*0.001);
  				cy = bezierPoint(that.getY()+10, cy1,cy2, endY, i*0.001);
  				tx = bezierTangent(that.getX(), cx1,cx2, endX, i*0.001);
 				ty = bezierTangent(that.getY()+10, cy1,cy2, endY, i*0.001);
 				a=atan2(ty,tx);
 				a+=PI/2;
				line(px,py,cx,cy);
				px=cx;
				py=cy;
	 		}
	 		push();
		  	translate(cx,cy);
			rotate(a);
  			triangle(-4,4,4,4,0,-4);
			pop();
		}
		else{
			state_=STABLE;
			that.drawNext();
			ai_.setCompleted(true);
		}
	}
	that.drawBreakNext = function(){
		that.drawStable();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			var endX=next_.getX() - (next_.nodeWidth())/2-2;
			var endY=next_.getY()+10;
			var cx1 = that.getX()+(endX-that.getX())/2;
			var cx2 = that.getX()+(endX-that.getX())/2;
			var cy1 = endY+30;
			var cy2 = endY+30;
			if(endX < that.getX()){
				cy1 = endY + 80;
				cy2 = endY + 80;
				cx1 = that.getX() + 40;
				cx2 = endX -40;
			}
			var px = bezierPoint(that.getX(), cx1, cx2, endX, 0.5);
  			var py = bezierPoint(that.getY()+10, cy1, cy2, endY, 0.5);
  			var tx = bezierTangent(that.getX(), cx1, cx2, endX, 0.5);
 			var ty = bezierTangent(that.getY()+10, cy1, cy2, endY, 0.5);
 			var a=atan2(ty,tx);
 			a+=PI/2;
			fill(redColour);
			stroke(redColour);
			push();
	 		translate(px,py);
			rotate(a);
  			line(-8,-8,8,8);
  			line(-8,8,8,-8);
			pop(); 			
		}
		else{
			that.setNext(null);
			ai_.setCompleted(true);
		}
	}
	that.drawRemoveNode=function(){

		that.drawStable();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			fill(color(redColour));
			stroke(color(redColour));
			push();
	 		translate(that.getX(),that.getY());
  			line(-38,-38,38,38);
  			line(-38,38,38,-38);
			pop(); 			
		}
		else{
			that.hide();
			state_=STABLE;
			ai_.setCompleted(true);
		}
	}
	that.draw = function(){
		if(isVisible_==true){
			switch (state_){
				case STABLE:
					that.drawStable(); break;
				case MOVELOCATION:
					that.drawMove(); break;
				case CHANGENEXT:
					that.drawChangeNext(); break;
				case BREAKNEXT:
					that.drawBreakNext(); break;
				case REMOVENODE:
					that.drawRemoveNode(); break;
			}		
		}
	}
	return that;
}
var DNode=function(spec){
	var that=AnimatedNode(spec);
	var prev_=spec.prev || null;
	var prevColour_=spec.prevColour_ || color(greenColour);
	that.nodeHeight_=75;

	that.setPrev=function(p){
		prev_=p;
	}
	that.drawNode=function(){
		push();
		recMode(CENTER);
		fill(bgColour_);
		stroke(0);
		rect(that.getX(),that.getY(),nodeWidth_,nodeHeight_,5,5,5,5);
		fill(fontColour_);
		stroke(fontColour_);
		textAlign(CENTER);
		text(data_,that.getX(),that.getY()-5);
		text("p",that.getX()-15,that.getY()+10);
		text("n",that.getX()-15,that.getY()+30);
		pop();
	}
	that.drawPrev=function(){
		fill(prevColour_);
		stroke(prevColour_);
		ellipse(that.getX(),that.getY()+10,5,5);
		if(prev_ != null){
			noFill();
			var endX=prev_.getX() + (prev_.nodeWidth())/2+2;
			var endY=prev_.getY()+10;
			var cx1 = that.getX()+(endX-that.getX())/2;
			var cx2 = that.getX()+(endX-that.getX())/2;
			var cy1 = endY-30;
			var cy2 = endY-30;
			if(endX > that.getX()){
				cy1 = endY - 120;
				cy2 = endY - 120;
				cx1 = that.getX() - 180;
				cx2 = endX + 180;
			}
			bezier(that.getX(),that.getY()+10, cx1,cy1,cx2,cy2,  endX,endY);
  			var tx = bezierTangent(that.getX(), cx1,cx2, endX, 1);
 			var ty = bezierTangent(that.getY()+10, cy1,cy2, endY, 1);
 			var a=atan2(ty,tx);
 			a+=PI/2;
			fill(nextColour_);
			push();
		  	translate(endX,endY);
			rotate(a);
  			triangle(-4,4,4,4,0,-4);
			pop(); 			
		}
	}
	that.drawStable=function(){
		that.drawNode();
		that.drawNext();
		that.drawPrev();
	}
	that.drawChangeNext=function(){
		that.drawNode();
		that.drawPrev();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
 		stroke(nextColour_);
		fill(nextColour_);
		ellipse(that.getX(),that.getY()+25,5,5);
		if(frame < 1){
			var endX=next_.getX() - (next_.nodeWidth())/2-2;
			var endY=next_.getY()+25;
			var px =bezierPoint(that.getX(), that.getX()+(endX-that.getX())/2, that.getX()+(endX-that.getX())/2, endX, 0);
  			var py = bezierPoint(that.getY()+25, endY+30, endY+30, endY, 0);
  			var cx,cy;
  			var tx,ty;
  			var a;
			var cx1 = that.getX()+(endX-that.getX())/2;
			var cx2 = that.getX()+(endX-that.getX())/2;
			var cy1 = endY+30;
			var cy2 = endY+30;
			if(endX < that.getX()){
				cy1 = endY + 60;
				cy2 = endY + 60;
				cx1 = that.getX() + 30;
				cx2 = endX -30;
			}
			for(var i=1;i<frame*1000;i++){
				cx = bezierPoint(that.getX(), cx1,cx2, endX, i*0.001);
  				cy = bezierPoint(that.getY()+25, cy1,cy2, endY, i*0.001);
  				tx = bezierTangent(that.getX(), cx1,cx2, endX, i*0.001);
 				ty = bezierTangent(that.getY()+25, cy1,cy2, endY, i*0.001);
 				a=atan2(ty,tx);
 				a+=PI/2;
				line(px,py,cx,cy);
				px=cx;
				py=cy;
	 		}
	 		push();
		  	translate(cx,cy);
			rotate(a);
  			triangle(-4,4,4,4,0,-4);
			pop();
		}
		else{
			state_=STABLE;
			drawNext();
			ai_.setCompleted(true);
		}
	}
	that.drawChangePrev=function(){
		that.drawNode();
		that.drawNext();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
 		stroke(prevColour_);
		fill(prevColour_);
		ellipse(that.getX(),that.getY()+10,5,5);
		if(frame < 1){
			var endX=prev_.getX() + (prev_.nodeWidth())/2+2;
			var endY=prev_.getX()+10;
 			var cx,cy;
  			var tx,ty;
  			var a;
			var cx1 = that.getX()+(endX-that.getX())/2;
			var cx2 = that.getX()+(endX-that.getX())/2;
			var cy1 = endY-30;
			var cy2 = endY-30;
			if(endX > that.getX()){
				cy1 = endY - 120;
				cy2 = endY - 120;
				cx1 = that.getX() - 180;
				cx2 = endX +180;
			}
			var px = bezierPoint(that.getX(), cx1,cx2, endX, 0);
  			var py = bezierPoint(that.getX()+10,cy1,cy2, endY, 0);

			for(var i=1;i<frame*1000;i++){
				cx = bezierPoint(that.getX(), cx1,cx2, endX, i*0.001);
  				cy = bezierPoint(that.getX()+10, cy1,cy2, endY, i*0.001);

				line(px,py,cx,cy);
				px=cx;
				py=cy;
	 		}
  			tx = bezierTangent(that.getX(), cx1,cx2, endX, frame);
 			ty = bezierTangent(that.getX()+10, cy1,cy2, endY, frame);
 			a=atan2(ty,tx);
 			a+=PI/2;
 			push();
		  	translate(cx,cy);
			rotate(a);
  			triangle(-4,4,4,4,0,-4);
			pop();
		}
		else{
			state_=STABLE;
			drawNext();
			drawPrev();
			ai_.setCompleted(true);
		}
	}
	that.drawBreakNext=function(){
		that.drawStable();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			var endX=next_.getX() - (next_.nodeWidth())/2-2;
			var endY=next_.getY()+25;
			var cx1 = that.getX()+(endX-that.getX())/2;
			var cx2 = that.getX()+(endX-that.getX())/2;
			var cy1 = endY+30;
			var cy2 = endY+30;
			if(endX < that.getX()){
				cy1 = endY + 60;
				cy2 = endY + 60;
				cx1 = that.getX() + 30;
				cx2 = endX -30;
			}
			var px = bezierPoint(that.getX(), cx1,cx2, endX, 0.5);
  			var py = bezierPoint(that.getY()+25, cy1,cy2, endY, 0.5);
  			var tx = bezierTangent(that.getX(), cx1,cx2, endX, 0.5);
 			var ty = bezierTangent(that.getY()+25, cy1,cy2, endY, 0.5);
 			var a=atan2(ty,tx);
 			a+=PI/2;
			fill(redColour);
			stroke(redColour);
			push();
	 		translate(px,py);
			rotate(a);
  			line(-10,-10,10,10);
  			line(-10,10,10,-10);
			pop(); 			
		}
		else{
			that.setNext(null);
			ai_.setCompleted(true);
		}
	}
	that.drawBreakPrev=function(){
		that.drawStable();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			var endX=prev_.getX() + (prev_.nodeWidth())/2+2;
			var endY=prev_.getY()+10;
			var endX=prev_.getX()- (prev_.nodeWidth())/2-2;
			var endY=prev_.getY()+10;
			var cx1 = that.getX()+(endX-that.getX())/2;
			var cx2 = that.getX()+(endX-that.getX())/2;
			var cy1 = endY-30;
			var cy2 = endY-30;
			if(endX > that.getX()){
				cy1 = endY - 120;
				cy2 = endY - 120;
				cx1 = that.getX() - 180;
				cx2 = endX +180;
			}
			var px = bezierPoint(that.getX(), cx1,cx2, endX, 0.5);
  			var py = bezierPoint(that.getY()+10, cy1,cy2, endY, 0.5);
  			var tx = bezierTangent(that.getX(), cx1,cx2, endX, 0.5);
 			var ty = bezierTangent(that.getY()+10, cy1,cy2, endY, 0.5);

 			var a=atan2(ty,tx);
 			a+=PI/2;
			fill(redColour);
			stroke(redColour);
			push();
		  	translate(px,py);
			rotate(a);
  			line(-10,-10,10,10);
  			line(-10,10,10,-10);
			pop(); 			
		}
		else{
			that.setPrev(null);
			ai_.setCompleted(true);
		}

	}
	that.drawRemoveNode=function(){
		that.drawStable();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			fill(redColour);
			stroke(redColour);
			push();
	 		translate(that.getX(),that.getY());
  			line(-38,-38,38,38);
  			line(-38,38,38,-38);
			pop(); 			
		}
		else{
			that.hide();
			state_=STABLE;
			ai_.setCompleted(true);
		}
	}
	that.draw=function(){
		if(isVisible_==true){
			switch (state_){
				case STABLE:
					that.drawStable(); break;
				case MOVELOCATION:
					that.drawMove(); break;
				case CHANGENEXT:
					that.drawChangeNext(); break;
				case CHANGEPREV:
					that.drawChangePrev(); break;
				case BREAKNEXT:
					that.drawBreakNext(); break;
				case BREAKPREV:
					that.drawBreakPrev(); break;
				case REMOVENODE:
					that.drawRemoveNode(); break;
			}
		}
	}
	return that;

}