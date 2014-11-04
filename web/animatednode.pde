class AnimatedNode extends AnimationObject{
	int data_;
	AnimatedNode next_;
	color bgColour_;
	color fontColour_;
	color nextColour_;
	float stateStartTime_;
	float animationDuration_;
	int state_;
	int visibility_;
	float nodeHeight_;
	float nodeWidth_;

	int destX_;
	int destY_;
	int startX_;
	int startY_;
	AnimationInstruction ai_;
	AnimatedNode(int v, int x, int y){
		super(x,y);
		data_=v;
		next_=null;
		bgColour_=whiteColour;
		fontColour_=blueColour;
		nextColour_=greenColour;
		state_=STABLE;
 		nodeWidth_=50;
		nodeHeight_=50;
		animationDuration_=1000;
		stateStartTime_=millis();
		visibility_=VISIBLE;
	}
	AnimatedNode(int x, int y){
		super(x,y);
		data_=0;
		next_=null;
		bgColour_=whiteColour;
		fontColour_=blueColour;
		nextColour_=greenColour;
		state_=STABLE;
 		nodeWidth_=50;
		nodeHeight_=50;
		animationDuration_=1000;
		stateStartTime_=millis();
		visibility_=VISIBLE;
	}
	void setNext(AnimationNode n){
		next_=n;

	}
	void setVisibility(int vis){
        visibility_=vis;
    }
	void move(int dx,int dy){
		destX_=dx;
		destY_=dy;
		startX_=x_;
		startY_=y_;
	}
	void process(AnimationInstruction ai){
		ai_=ai;
		switch(ai.instruction_){
			case SET:
				ai.setCompleted(true);
				data_=ai.a_;
			case CHANGENEXT:
				state_=CHANGENEXT;
				setNext(ai.n_);
				stateStartTime_=millis();
				break;
			case BREAKNEXT:
				if(next_!=null){
					state_=BREAKNEXT;

					stateStartTime_=millis();
				}
				else{
					state_=STABLE;
				}
				break;
			case REMOVENODE:
				state_=REMOVENODE;
				stateStartTime_=millis();
				break;
			case MOVELOCATION:
				state_=MOVELOCATION;
				move(ai.a_,ai.b_);
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
	void drawNode(){
		pushStyle();
		rectMode(CENTER);
		fill(bgColour_);
		stroke(0);
		rect(x_,y_,nodeWidth_,nodeHeight_,5,5,5,5);
		fill(fontColour_);
		stroke(fontColour_);
		textAlign(CENTER);
		text(data_,x_,y_-5);
		popStyle();
	}
	void drawNext(){
		fill(nextColour_);
		stroke(nextColour_);
		ellipse(x_,y_+10,5,5);
		if(next_ != null){
			noFill();
			int endX=next_.x_ - (next_.nodeWidth_)/2-2;
			int endY=next_.y_+10;
			float cx1 = x_+(endX-x_)/2;
			float cx2 = x_+(endX-x_)/2;
			float cy1 = endY+30;
			float cy2 = endY+30;
			if(endX < x_){
				cy1 = endY + 80;
				cy2 = endY + 80;
				cx1 = x_ + 40;
				cx2 = endX -40;
			}
			bezier(x_,y_+10, cx1,cy1,cx2,cy2,  endX,endY);
  			float tx = bezierTangent(x_, cx1,cx2, endX, 1);
 			float ty = bezierTangent(y_+10, cy1,cy2, endY, 1);
 			float a=atan2(ty,tx);
 			a+=PI/2;
			fill(nextColour_);
			pushMatrix();
		  	translate(endX,endY);
			rotate(a);
  			triangle(-4,4,4,4,0,-4);
			popMatrix(); 			
		}
	}
	void drawStable(){
		drawNode();
		drawNext();
	}
	void drawMove(){
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			x_=startX_+(destX_-startX_)*frame;
			y_=startY_+(destY_-startY_)*frame;
		}
		else{
			x_=destX_;
			y_=destY_;
			state_=STABLE;
			ai_.setCompleted(true);
		}
		drawStable();
	}
	void drawChangeNext(){
		drawNode();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
		stroke(nextColour_);
		fill(nextColour_);
		ellipse(x_,y_+10,5,5);
		if(next_!= null && frame < 1){
			int endX=next_.x_ - (next_.nodeWidth_)/2-2;
			int endY=next_.y_+10;
			float px =bezierPoint(x_, x_+(endX-x_)/2, x_+(endX-x_)/2, endX, 0);
			float py = bezierPoint(y_+10, endY+30, endY+30, endY, 0);
			float cx,cy;
			float tx,ty;
			float a;
			float cx1 = x_+(endX-x_)/2;
			float cx2 = x_+(endX-x_)/2;
			float cy1 = endY+30;
			float cy2 = endY+30;
			if(endX < x_){
				cy1 = endY + 80;
				cy2 = endY + 80;
				cx1 = x_ + 40;
				cx2 = endX -40;
			}
			for(int i=1;i<frame*1000;i++){
				cx = bezierPoint(x_, cx1,cx2, endX, i*0.001);
  				cy = bezierPoint(y_+10, cy1,cy2, endY, i*0.001);
  				tx = bezierTangent(x_, cx1,cx2, endX, i*0.001);
 				ty = bezierTangent(y_+10, cy1,cy2, endY, i*0.001);
 				a=atan2(ty,tx);
 				a+=PI/2;
				line(px,py,cx,cy);
				px=cx;
				py=cy;
	 		}
	 		pushMatrix();
		  	translate(cx,cy);
			rotate(a);
  			triangle(-4,4,4,4,0,-4);
			popMatrix();
		}
		else{
			state_=STABLE;
			drawNext();
			ai_.setCompleted(true);
		}
	}
	void drawBreakNext(){
		drawStable();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			int endX=next_.x_ - (next_.nodeWidth_)/2-2;
			int endY=next_.y_+10;
			float px = bezierPoint(x_, x_+(endX-x_)/2, x_+(endX-x_)/2, endX, 0.5);
  			float py = bezierPoint(y_+10, endY+30, endY+30, endY, 0.5);
  			float tx = bezierTangent(x_, x_+(endX-x_)/2, x_+(endX-x_)/2, endX, 0.5);
 			float ty = bezierTangent(y_+10, endY+30, endY+30, endY, 0.5);
 			float a=atan2(ty,tx);
 			a+=PI/2;
			fill(redColour);
			stroke(redColour);
			pushMatrix();
	 		translate(px,py);
			rotate(a);
  			line(-8,-8,8,8);
  			line(-8,8,8,-8);
			popMatrix(); 			
		}
		else{
			setNext(null);
			ai_.setCompleted(true);
		}
	}
	void drawRemoveNode(){

		drawStable();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			fill(redColour);
			stroke(redColour);
			pushMatrix();
	 		translate(x_,y_);
  			line(-38,-38,38,38);
  			line(-38,38,38,-38);
			popMatrix(); 			
		}
		else{
			setVisibility(HIDDEN);
			state_=STABLE;
			ai_.setCompleted(true);
		}
	}

	void draw(){
		if(visibility_ == VISIBLE){
			switch (state_){
				case STABLE:
					drawStable(); break;
				case MOVELOCATION:
					drawMove(); break;
				case CHANGENEXT:
					drawChangeNext(); break;
				case BREAKNEXT:
					drawBreakNext(); break;
				case REMOVENODE:
					drawRemoveNode(); break;
			}		
		}
	}
}
