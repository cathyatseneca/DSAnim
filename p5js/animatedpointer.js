var AnimatedPointer = function(spec){
	var that = AnimationObject(spec);
	var ptr_ = spec.ptr || null;
    var name_ = spec.name || "";
	var bgColour_ = color(whiteColour);
	var fontColour_ = color(whiteColour);
	var ptrColour_ = color(greenColour);
	var nodeWidth_ = spec.width || 25;
	var nodeHeight_ = spec.height || 25;
	var stateStartTime_ = 0;
	var animationDuration_ =spec.animationDuration_ || 500;
	var state_ = STABLE;
	var isVisible_ = spec.isVisible_;
	var ai_;

	if(isVisible_==undefined){
		isVisible_= true;
	}

	that.setPtr=function (n){
		ptr_=n;

	}
	that.process=function(ai){
		ai_=ai;
		ai.instruction();
	}
	that.setVisibility=function(v){
		isVisible_=v;
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
		text(name_,that.getX(),that.getY()-nodeHeight_/2-10);
		pop();
	}
	that.drawPtr=function(){
		fill(ptrColour_);
		stroke(ptrColour_);
		ellipse(that.getX(),that.getY(),5,5);
		if(ptr_ != null){
			noFill();
			var endX=ptr_.getX();
			var endY=ptr_.getY() - (ptr_.nodeHeight()/2);
			line(that.getX(),that.getY(),endX,endY);
			var a=atan2((endX-that.getX()),(endY-that.getY()));
			a-=PI;
			fill(ptrColour_);
			push();
			translate(endX,endY);
			rotate(-a);
			triangle(-4,4,4,4,0,-4);
			pop(); 			

		}
	}
	that.drawChangeNext=function(){
		drawNode();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;		
		fill(ptrColour_);
		stroke(ptrColour_);
		ellipse(that.getX(),that.getY(),5,5);
		if(frame < 1){
			if(ptr_ != null){
				noFill();
				var endX=ptr_.getX();
				var endY=ptr_.getY() - (ptr_.nodeHeight()/2);

				endX = that.getX()+(endX-that.getX())*frame;
				endY = that.getY()+(endY-that.getY())*frame;
				line(that.getX(),that.getY(),endX,endY);
				var a=atan2((endX-that.getX()),(endY-that.getY()));
				a-=PI;
				fill(ptrColour_);
				push();
				translate(endX,endY);
				rotate(-a);
				triangle(-4,4,4,4,0,-4);
				pop(); 			

			}
			else{
				state_=STABLE;
				drawPtr();
				ai_.setCompleted(true);
			}	
		}
		else{
			state_=STABLE;
			drawPtr();
			ai_.setCompleted(true);
		}
	}
	that.drawStable=function(){
		that.drawNode();
		that.drawPtr();
	}

	that.draw=function(){
		if(isVisible_==true){
			switch (state_){
				case STABLE:
					that.drawStable(); break;
				case CHANGENEXT:
					that.drawChangeNext(); break;
			}		
		}
	}
	return that;

}