//a doubly linked node
class DNode extends AnimatedNode{

	AnimatedNode prev_;
	color prevColour_;
	float stateStartTime_;
	float animationDuration_;
	int state_;
	float nodeHeight_;
	float nodeWidth_;
	int destX_;
	int destY_;
	int startX_;
	int startY_;
	AnimationInstruction ai_;
	DNode(int v, int x, int y){
		super(v,x,y);
		prev_=null;
		prevColour_=greenColour;
		state_=STABLE;
		nodeWidth_=50;
		nodeHeight_=75;
		animationDuration_=1000;
		stateStartTime_=millis();
	}

	void setPrev(Dnode p){
		prev_=p;
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
			case CHANGEPREV:
				state_=CHANGEPREV;
				setPrev(ai.n_);
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
			case BREAKPREV:
				if(prev_!=null){
					state_=BREAKPREV;

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
		String s="" + data_;
		textAlign(CENTER);
		text(s,x_,y_-15);
		text("p",x_-15,y_+10);
		text("n",x_-15,y_+30);
		popStyle();
	}
	void drawNext(){
		fill(nextColour_);
		stroke(nextColour_);
		ellipse(x_,y_+25,5,5);
		if(next_ != null){
			noFill();
			int endX=next_.x_ - (next_.nodeWidth_)/2-2;
			int endY=next_.y_+25;
			float cx1 = x_+(endX-x_)/2;
			float cx2 = x_+(endX-x_)/2;
			float cy1 = endY+30;
			float cy2 = endY+30;
			if(endX < x_){
				cy1 = endY + 60;
				cy2 = endY + 60;
				cx1 = x_ + 30;
				cx2 = endX -30;
			}
			bezier(x_,y_+25, cx1,cy1,cx2,cy2,  endX,endY);
  			float tx = bezierTangent(x_, cx1,cx2, endX, 1);
 			float ty = bezierTangent(y_+25, cy1,cy2, endY, 1);
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
	void drawPrev(){
		fill(prevColour_);
		stroke(prevColour_);
		ellipse(x_,y_+10,5,5);
		if(prev_ != null){
			noFill();
			int endX=prev_.x_ + (prev_.nodeWidth_)/2+2;
			int endY=prev_.y_+10;
			float cx1 = x_+(endX-x_)/2;
			float cx2 = x_+(endX-x_)/2;
			float cy1 = endY-30;
			float cy2 = endY-30;
			if(endX > x_){
				cy1 = endY - 120;
				cy2 = endY - 120;
				cx1 = x_ - 180;
				cx2 = endX + 180;
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
		drawPrev();
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
		drawPrev();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
 		stroke(nextColour_);
		fill(nextColour_);
		ellipse(x_,y_+25,5,5);
		if(frame < 1){
			int endX=next_.x_ - (next_.nodeWidth_)/2-2;
			int endY=next_.y_+25;
			float px =bezierPoint(x_, x_+(endX-x_)/2, x_+(endX-x_)/2, endX, 0);
  			float py = bezierPoint(y_+25, endY+30, endY+30, endY, 0);
  			float cx,cy;
  			float tx,ty;
  			float a;
			float cx1 = x_+(endX-x_)/2;
			float cx2 = x_+(endX-x_)/2;
			float cy1 = endY+30;
			float cy2 = endY+30;
			if(endX < x_){
				cy1 = endY + 60;
				cy2 = endY + 60;
				cx1 = x_ + 30;
				cx2 = endX -30;
			}
			for(int i=1;i<frame*1000;i++){
				cx = bezierPoint(x_, cx1,cx2, endX, i*0.001);
  				cy = bezierPoint(y_+25, cy1,cy2, endY, i*0.001);
  				tx = bezierTangent(x_, cx1,cx2, endX, i*0.001);
 				ty = bezierTangent(y_+25, cy1,cy2, endY, i*0.001);
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
	void drawChangePrev(){
		drawNode();
		drawNext();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
 		stroke(prevColour_);
		fill(prevColour_);
		ellipse(x_,y_+10,5,5);
		if(frame < 1){
			int endX=prev_.x_ + (prev_.nodeWidth_)/2+2;
			int endY=prev_.y_+10;
 			float cx,cy;
  			float tx,ty;
  			float a;
			float cx1 = x_+(endX-x_)/2;
			float cx2 = x_+(endX-x_)/2;
			float cy1 = endY-30;
			float cy2 = endY-30;
			if(endX > x_){
				cy1 = endY - 120;
				cy2 = endY - 120;
				cx1 = x_ - 180;
				cx2 = endX +180;
			}
			float px = bezierPoint(x_, cx1,cx2, endX, 0);
  			float py = bezierPoint(y_+10,cy1,cy2, endY, 0);

			for(int i=1;i<frame*1000;i++){
				cx = bezierPoint(x_, cx1,cx2, endX, i*0.001);
  				cy = bezierPoint(y_+10, cy1,cy2, endY, i*0.001);

				line(px,py,cx,cy);
				px=cx;
				py=cy;
	 		}
  			tx = bezierTangent(x_, cx1,cx2, endX, frame);
 			ty = bezierTangent(y_+10, cy1,cy2, endY, frame);
 			a=atan2(ty,tx);
 			a+=PI/2;
 			pushMatrix();
		  	translate(cx,cy);
			rotate(a);
  			triangle(-4,4,4,4,0,-4);
			popMatrix();
		}
		else{
			state_=STABLE;
			drawNext();
			drawPrev();
			ai_.setCompleted(true);
		}
	}
	void drawBreakNext(){
		drawStable();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			int endX=next_.x_ - (next_.nodeWidth_)/2-2;
			int endY=next_.y_+25;
			float cx1 = x_+(endX-x_)/2;
			float cx2 = x_+(endX-x_)/2;
			float cy1 = endY+30;
			float cy2 = endY+30;
			if(endX < x_){
				cy1 = endY + 60;
				cy2 = endY + 60;
				cx1 = x_ + 30;
				cx2 = endX -30;
			}
			float px = bezierPoint(x_, cx1,cx2, endX, 0.5);
  			float py = bezierPoint(y_+25, cy1,cy2, endY, 0.5);
  			float tx = bezierTangent(x_, cx1,cx2, endX, 0.5);
 			float ty = bezierTangent(y_+25, cy1,cy2, endY, 0.5);
 			float a=atan2(ty,tx);
 			a+=PI/2;
			fill(redColour);
			stroke(redColour);
			pushMatrix();
	 		translate(px,py);
			rotate(a);
  			line(-10,-10,10,10);
  			line(-10,10,10,-10);
			popMatrix(); 			
		}
		else{
			setNext(null);
			ai_.setCompleted(true);
		}
	}
	void drawBreakPrev(){
		drawStable();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1){
			int endX=prev_.x_ + (prev_.nodeWidth_)/2+2;
			int endY=prev_.y_+10;
			int endX=prev_.x_ - (prev_.nodeWidth_)/2-2;
			int endY=prev_.y_+10;
			float cx1 = x_+(endX-x_)/2;
			float cx2 = x_+(endX-x_)/2;
			float cy1 = endY-30;
			float cy2 = endY-30;
			if(endX > x_){
				cy1 = endY - 120;
				cy2 = endY - 120;
				cx1 = x_ - 180;
				cx2 = endX +180;
			}
			float px = bezierPoint(x_, cx1,cx2, endX, 0.5);
  			float py = bezierPoint(y_+10, cy1,cy2, endY, 0.5);
  			float tx = bezierTangent(x_, cx1,cx2, endX, 0.5);
 			float ty = bezierTangent(y_+10, cy1,cy2, endY, 0.5);

 			float a=atan2(ty,tx);
 			a+=PI/2;
			fill(redColour);
			stroke(redColour);
			pushMatrix();
		  	translate(px,py);
			rotate(a);
  			line(-10,-10,10,10);
  			line(-10,10,10,-10);
			popMatrix(); 			
		}
		else{
			setPrev(null);
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
				case CHANGEPREV:
					drawChangePrev(); break;
				case BREAKNEXT:
					drawBreakNext(); break;
				case BREAKPREV:
					drawBreakPrev(); break;
				case REMOVENODE:
					drawRemoveNode(); break;
			}
		}
	}


}