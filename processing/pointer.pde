class Pointer extends AnimationObject{
	AnimatedNode ptr_;
    String name_;
	color bgColour_;
	color fontColour_;
	color ptrColour_;
	float nodeWidth_;
	float nodeHeight_;
	float stateStartTime_;
	float animationDuration_;
	int state_;
	int visibility_;
	AnimationInstruction ai_;
	Pointer(String name,int x, int y){
		super(x,y);
		name_=name;
		ptr_=null;
		bgColour_=whiteColour;
		fontColour_=whiteColour;
		ptrColour_=greenColour;
		state_=STABLE;
 		nodeWidth_=25;
		nodeHeight_=25;
		animationDuration_=1000;
		stateStartTime_=millis();
		visibility_=VISIBLE;
	}
	void setPtr(AnimatedNode n){
		ptr_=n;

	}
	void process(AnimationInstruction ai){
		ai_=ai;
		switch(ai.instruction_){
			case SET:
				ai.setCompleted(true);
				setPtr(ai.n_);
			case CHANGENEXT:
				state_=CHANGENEXT;
				setPtr(ai.n_);
				stateStartTime_=millis();
				break;
            case SETVISIBILITY:
                setVisibility(ai.a_);
                ai.setCompleted(true);
                break;
            default:
				println("error no such instruction: " + ai.instruction_);
		}
	}
	void setVisibility(int v){
		visibility_=v;
	}
	void drawNode(){
		pushStyle();
		rectMode(CENTER);
		fill(bgColour_);
		stroke(0);
		rect(x_,y_,nodeWidth_,nodeHeight_,5,5,5,5);
		fill(fontColour_);
		stroke(fontColour_);
		textAlign(CENTER);
		text(name_,x_,y_-nodeHeight_/2-10);
		popStyle();
	}
	void drawPtr(){
		fill(ptrColour_);
		stroke(ptrColour_);
		ellipse(x_,y_,5,5);
		if(ptr_ != null){
			noFill();
			float endX=ptr_.x_;
			float endY=ptr_.y_ - (ptr_.nodeHeight_/2);
			line(x_,y_,endX,endY);
			float a=atan2((endX-x_),(endY-y_));
			a-=PI;
			fill(ptrColour_);
			pushMatrix();
			translate(endX,endY);
			rotate(-a);
			triangle(-4,4,4,4,0,-4);
			popMatrix(); 			

		}
	}
	void drawChangeNext(){
		drawNode();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;		
		fill(ptrColour_);
		stroke(ptrColour_);
		ellipse(x_,y_,5,5);
		if(frame < 1){
			if(ptr_ != null){
				noFill();
				float endX=ptr_.x_;
				float endY=ptr_.y_ - (ptr_.nodeHeight_/2);

				endX = x_+(endX-x_)*frame;
				endY = y_+(endY-y_)*frame;
				line(x_,y_,endX,endY);
				float a=atan2((endX-x_),(endY-y_));
				a-=PI;
				fill(ptrColour_);
				pushMatrix();
				translate(endX,endY);
				rotate(-a);
				triangle(-4,4,4,4,0,-4);
				popMatrix(); 			

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
	void drawStable(){
		drawNode();
		drawPtr();
	}

	void draw(){
		if(visibility_ == VISIBLE){
			switch (state_){
				case STABLE:
					drawStable(); break;
				case CHANGENEXT:
					drawChangeNext(); break;
			}		
		}
	}

}