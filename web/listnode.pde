
class ListNode extends AnimatedNode{
	String [] labels_;
	int numLabels_;
	AnimatedNode [] pointers_;
	int ptrIdx_;
	ListNode(String [] label,int numLabels, int x, int y){
		super(x,y);
		nodeWidth_ = 75;
		nodeHeight_ = 25*numLabels;
		labels_=new String[numLabels];
		pointers_ = new AnimatedNode[3];
		numLabels_=numLabels;
		for(i=0;i<numLabels;i++){
			labels_[i]=label[i];
			pointers_[i]=null;
		}
	}

	void setNext(AnimatedNode n,int idx){
		pointers_[idx]=n;
		ptrIdx_=idx;
	}

	void process(AnimationInstruction ai){
		ai_=ai;
		switch(ai.instruction_){
			case CHANGENEXT:
				state_=CHANGENEXT;
				setNext(ai.n_,ai.a_);
				stateStartTime_=millis();
				break;
			case BREAKNEXT:
				if(pointers_[ai.a_]!=null){
					state_=BREAKNEXT;
					ptrIdx_=ai.a_;
					stateStartTime_=millis();
				}
				else{
					state_=STABLE;
				}
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
		float topY = y_-nodeHeight_/2;
		textAlign(LEFT);
		for(i=0;i<numLabels_;i++){
			text(labels_[i],x_-27,topY+15 + 25 * (i));
		}
		popStyle();
	}
	void drawNext(int idx){
		float topY = y_-nodeHeight_/2;
		int endX,endY;
		float cx1,cx2;
		float cy1,cy2;
		float tx,ty;
		float a;
	
		if(idx == 0){
			stroke(nextColour_);
			fill(nextColour_);
			ellipse(x_+15,topY+13,5,5);
			if(pointers_[0] !=null){
				//first pointer always points to top of a node
				endX=pointers_[0].x_;
				endY=pointers_[0].y_-(pointers_[0].nodeHeight_/2);
				cx1 = x_;
				cx2 = endX+15;
				cy1 = endY-30;
				cy2 = endY-30;
				noFill();
				bezier(x_+15,topY+13, cx1,cy1,cx2,cy2,  endX,endY);
  				tx = bezierTangent(x_+15, cx1,cx2, endX, 1);
 				ty = bezierTangent(topY+13, cy1,cy2, endY, 1);
	 			a=atan2(ty,tx);
 				a+=PI/2;
				fill(nextColour_);
				pushMatrix();
				translate(endX,endY);
				rotate(a);
  				triangle(-4,4,4,4,0,-4);
				popMatrix();
			}
		}
		else if(idx == 1){
			stroke(nextColour_);
			fill(nextColour_);
			ellipse(x_+15,topY+38,5,5);
			if(pointers_[1] !=null){
				if(numLabels_ == 2){
					endX=pointers_[1].x_;
					endY=pointers_[1].y_+(pointers_[1].nodeHeight_/2)+4;
					cx1 = x_;
					cx2 = endX+15;
					cy1 = endY+90;
					cy2 = endY+90;
					sy=topY+38;
				}
				else{
					endX=pointers_[1].x_ - (pointers_[1].nodeWidth_/2)-2;
					endY=pointers_[1].y_-(pointers_[1].nodeHeight_/2)+10;
					cx1 = x_+(endX-x_)/2;
					cx2 = x_+(endX-x_)/2;
					cy1 = endY-10;
					cy2 = endY-10;
				}
				noFill();
				bezier(x_+15,topY+38, cx1,cy1,cx2,cy2,  endX,endY);
  				tx = bezierTangent(x_+15, cx1,cx2, endX, 1);
 				ty = bezierTangent(topY+38, cy1,cy2, endY, 1);
 				a=atan2(ty,tx);
 				a+=PI/2;
				fill(nextColour_);
				pushMatrix();
				translate(endX,endY);
				rotate(a);
  				triangle(-4,4,4,4,0,-4);
				popMatrix();
			}
		}
		else if(idx==2){
			stroke(nextColour_);
			fill(nextColour_);
			ellipse(x_+15,topY+63,5,5);
			if(pointers_[2] !=null){
				endX=pointers_[2].x_;
				endY=pointers_[2].y_+(pointers_[2].nodeHeight_/2)+4;
				cx1 = x_;
				cx2 = endX+15;
				cy1 = endY+90;
				cy2 = endY+90;
				noFill();
				bezier(x_+15,topY+63, cx1,cy1,cx2,cy2,  endX,endY);
  				tx = bezierTangent(x_+15, cx1,cx2, endX, 1);
 				ty = bezierTangent(topY+63, cy1,cy2, endY, 1);
	 			a=atan2(ty,tx);
 				a+=PI/2;
				fill(nextColour_);
				pushMatrix();
				translate(endX,endY);
				rotate(a);
  				triangle(-4,4,4,4,0,-4);
				popMatrix();
			}
		}

	}
	void drawStable(){
		drawNode();
		int i;
		for(i=0;i<numLabels_;i++){
			drawNext(i);
		}
	}

	void drawChangeNext(int idx){

		drawNode();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1 && pointers_[idx]!=null){
			int i;
			for(i=0;i<numLabels_;i++){
				if(i!=idx){
					drawNext(i);
				}
			}
			float topY = y_-nodeHeight_/2;
			int endX,endY;
			float cx1,cx2;
			float cy1,cy2;
			float tx,ty;
			float a;
			float px,py;
			float sx,sy;
			sx=x_+15;
			if(idx == 0){
				sy=topY+13;
				if(pointers_[0] !=null){

					//first pointer always points to top of a node
					endX=pointers_[0].x_;
					endY=pointers_[0].y_-(pointers_[0].nodeHeight_/2);
  					cx1 = x_;
					cx2 = endX+15;
					cy1 = endY-30;
					cy2 = endY-30;

					px =bezierPoint(x_+15,cx1,cx2, endX, 0);
  					py = bezierPoint(topY+13, cy1,cy2, endY, 0);
	  				tx = bezierTangent(x_+15, cx1,cx2, endX, 1);
	 				ty = bezierTangent(topY+13, cy1,cy2, endY, 1);
		 			a=atan2(ty,tx);
 					a+=PI/2;
				}
			}
			else if(idx == 1){
				sy=topY+38;
				if(pointers_[1] !=null){
					if(numLabels_ == 2){
						endX=pointers_[1].x_;
						endY=pointers_[1].y_+(pointers_[1].nodeHeight_/2)+4;
						cx1 = x_;
						cx2 = endX+15;
						cy1 = endY+90;
						cy2 = endY+90;
						sy=topY+38;
					}
					else{
						endX=pointers_[1].x_ - (pointers_[1].nodeWidth_/2)-2;
						endY=pointers_[1].y_-(pointers_[1].nodeHeight_/2)+10;
						cx1 = x_+(endX-x_)/2;
						cx2 = x_+(endX-x_)/2;
						cy1 = endY-10;
						cy2 = endY-10;
					}
					px =bezierPoint(x_+15,cx1,cx2, endX, 0);
  					py = bezierPoint(topY+38, cy1,cy2, endY, 0);
  					tx = bezierTangent(x_+15, cx1,cx2, endX, 1);
 					ty = bezierTangent(topY+38, cy1,cy2, endY, 1);
 					a=atan2(ty,tx);
 					a+=PI/2;
				}
			}
			else if(idx==2){
				sy=topY+63;
				if(pointers_[2] !=null){
					endX=pointers_[2].x_;
					endY=pointers_[2].y_+(pointers_[2].nodeHeight_/2)+4;
					cx1 = x_;
					cx2 = endX+15;
					cy1 = endY+90;
					cy2 = endY+90;

					px = bezierPoint(x_+15,cx1,cx2, endX, 0);
  					py = bezierPoint(topY+63, cy1,cy2, endY, 0);
  					tx = bezierTangent(x_+15, cx1,cx2, endX, 1);
 					ty = bezierTangent(topY+63, cy1,cy2, endY, 1);
	 				a=atan2(ty,tx);
 					a+=PI/2;
				}
			}
			stroke(nextColour_);
			fill(nextColour_);
			ellipse(sx,sy,5,5);
			noFill();

			for(int i=1;i<frame*1000;i++){
				cx = bezierPoint(sx, cx1,cx2, endX, i*0.001);
  				cy = bezierPoint(sy, cy1,cy2, endY, i*0.001);
 				tx = bezierTangent(sx, cx1,cx2, endX, i*0.001);
 				ty = bezierTangent(sy, cy1,cy2, endY, i*0.001);
 				a=atan2(ty,tx);
 				a+=PI/2;
				line(px,py,cx,cy);
				px=cx;
				py=cy;
 			}
 			fill(nextColour_);
		 	pushMatrix();
		  	translate(cx,cy);
			rotate(a);
 			triangle(-4,4,4,4,0,-4);
			popMatrix();
		}
		else{
			state_=STABLE;
			for(i=0;i<numLabels_;i++){
				drawNext(i);
			}
			ai_.setCompleted(true);
		}
	}
	void drawBreakNext(int idx){

		drawStable();
		float currTime=millis();
		float frame = (currTime-stateStartTime_)/animationDuration_;
		float topY = y_-nodeHeight_/2;
		if(frame < 1){
			int endX,endY;
			float cx1,cx2;
			float cy1,cy2;
			float tx,ty;
			float a;
			float px,py;
			float sx,sy;
			sx=x_+15;

			if(idx == 0){
				sy=topY+13;
				if(pointers_[0] !=null){
					//first pointer always points to top of a node
					endX=pointers_[0].x_;
					endY=pointers_[0].y_-(pointers_[0].nodeHeight_/2);
  					cx1 = x_;
					cx2 = endX+15;
					cy1 = endY-30;
					cy2 = endY-30;
					noFill();
					px = bezierPoint(sx,cx1,cx2, endX, 0.5);
  					py = bezierPoint(sy, cy1,cy2, endY, 0.5);
	  				tx = bezierTangent(sx, cx1,cx2, endX, 0.5);
	 				ty = bezierTangent(sy, cy1,cy2, endY, 0.5);
		 			a=atan2(ty,tx);
 					a+=PI/2;
				}
			}
			else if(idx == 1){
				sy=topY+38;
				if(pointers_[1] !=null){
					if(numLabels_ == 2){
						endX=pointers_[1].x_;
						endY=pointers_[1].y_+(pointers_[1].nodeHeight_/2)+4;
						cx1 = x_;
						cx2 = endX+15;
						cy1 = endY+90;
						cy2 = endY+90;
					}
					else{
						endX=pointers_[1].x_ - (pointers_[1].nodeWidth_/2)-2;
						endY=pointers_[1].y_-(pointers_[1].nodeHeight_/2)+10;
						cx1 = x_+(endX-x_)/2;
						cx2 = x_+(endX-x_)/2;
						cy1 = endY-10;
						cy2 = endY-10;
					}
					px =bezierPoint(sx,cx1,cx2, endX, 0.5);
  					py = bezierPoint(sy, cy1,cy2, endY, 0.5);
	  				tx = bezierTangent(sx, cx1,cx2, endX, 0.5);
	 				ty = bezierTangent(sy, cy1,cy2, endY, 0.5);
 					a=atan2(ty,tx);
 					a+=PI/2;
				}
			}
			else if(idx==2){
				sy=topY+63;
				if(pointers_[2] !=null){
					endX=pointers_[2].x_;
					endY=pointers_[2].y_+(pointers_[2].nodeHeight_/2)+4;
					cx1 = x_;
					cx2 = endX+15;
					cy1 = endY+90;
					cy2 = endY+90;
					px =bezierPoint(sx,cx1,cx2, endX, 0.5);
  					py = bezierPoint(sy, cy1,cy2, endY, 0.5);
	  				tx = bezierTangent(sx, cx1,cx2, endX, 0.5);
	 				ty = bezierTangent(sy, cy1,cy2, endY, 0.5);
	 				a=atan2(ty,tx);
 					a+=PI/2;
				}
			}



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
			setNext(null,idx);
			ai_.setCompleted(true);
		}
	}
	void draw(){

		switch (state_){
			case STABLE:
				drawStable(); break;
			case MOVELOCATION:
				drawMove(); break;
			case CHANGENEXT:
				drawChangeNext(ptrIdx_); break;
			case BREAKNEXT:
				drawBreakNext(ptrIdx_); break;

		}
	}
}
