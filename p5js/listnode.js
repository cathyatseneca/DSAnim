
var ListNode=function(spec){
	var that=AnimatedNode(spec);
	var labels_ = [];
	var numLabels_=spec.numLabels_ || 2;
	var pointers_=[];
	var ptrIdx_;
	var state_=STABLE;
	var bgColour_ = color(whiteColour);
	var fontColour_ = color(blueColour);
	var nextColour_ = color(greenColour);

	that.setNodeWidth(100);
	that.setNodeHeight(25*numLabels_);	
	if(spec.labels != undefined){
		for(i=0;i<numLabels_;i++){
			labels_[i]=spec.labels[i];
			pointers_[i]=null;
		}
	}
	else{
		labels_[0]="front_";
		labels_[1]="back_"
	}
	if(spec.pointers != undefined){
		for(i=0;i<numLabels_;i++){
			pointers_[i]=spec.pointers[i];
		}
	}
	that.setNext=function(n,idx){
		pointers_[idx]=n;
		ptrIdx_=idx;
	}

	that.process=function(ai){
		ai_=ai;
		ai.instruction();
	}
	that.drawNode=function(){
		push();
		rectMode(CENTER);
		fill(bgColour_);
		stroke(0);
		rect(that.getX(),that.getY(),that.nodeWidth(),that.nodeHeight(),5,5,5,5);
		fill(fontColour_);
		stroke(fontColour_);
		var topY = that.getY()-that.nodeHeight()/2;
		textAlign(LEFT);
		for(var i=0;i<numLabels_;i++){
			text(labels_[i],that.getX()-27,topY+15 + 25 * (i));
		}
		pop();
	}
	that.drawNext=function(idx){
		var topY = that.getY()-that.nodeHeight()/2;
		var endX,endY;
		var cx1,cx2;
		var cy1,cy2;
		var tx,ty;
		var a;
	
		if(idx == 0){
			stroke(nextColour_);
			fill(nextColour_);
			ellipse(that.getX()+15,topY+13,5,5);
			if(pointers_[0] !=null){
				//first pointer always points to top of a node
				endX=pointers_[0].getX();
				endY=pointers_[0].getY()-(pointers_[0].nodeHeight()/2);
				cx1 = that.getX();
				cx2 = endX+15;
				cy1 = endY-30;
				cy2 = endY-30;
				noFill();
				bezier(that.getX()+15,topY+13, cx1,cy1,cx2,cy2,  endX,endY);
  				tx = bezierTangent(that.getX()+15, cx1,cx2, endX, 1);
 				ty = bezierTangent(topY+13, cy1,cy2, endY, 1);
	 			a=atan2(ty,tx);
 				a+=PI/2;
				fill(nextColour_);
				push();
				translate(endX,endY);
				rotate(a);
  				triangle(-4,4,4,4,0,-4);
				pop();
			}
		}
		else if(idx == 1){
			stroke(nextColour_);
			fill(nextColour_);
			ellipse(that.getX()+15,topY+38,5,5);
			if(pointers_[1] !=null){
				if(numLabels_ == 2){
					endX=pointers_[1].getX();
					endY=pointers_[1].getY()+(pointers_[1].nodeHeight()/2)+4;
					cx1 = that.getX();
					cx2 = endX+15;
					cy1 = endY+90;
					cy2 = endY+90;
					sy=topY+38;
				}
				else{
					endX=pointers_[1].getX() - (pointers_[1].nodeWidth()/2)-2;
					endY=pointers_[1].getY()-(pointers_[1].nodeHeight()/2)+10;
					cx1 = that.getX()+(endX-that.getX())/2;
					cx2 = that.getX()+(endX-that.getX())/2;
					cy1 = endY-10;
					cy2 = endY-10;
				}
				noFill();
				bezier(that.getX()+15,topY+38, cx1,cy1,cx2,cy2,  endX,endY);
  				tx = bezierTangent(that.getX()+15, cx1,cx2, endX, 1);
 				ty = bezierTangent(topY+38, cy1,cy2, endY, 1);
 				a=atan2(ty,tx);
 				a+=PI/2;
				fill(nextColour_);
				push();
				translate(endX,endY);
				rotate(a);
  				triangle(-4,4,4,4,0,-4);
				pop();
			}
		}
		else if(idx==2){
			stroke(nextColour_);
			fill(nextColour_);
			ellipse(that.getX()+15,topY+63,5,5);
			if(pointers_[2] !=null){
				endX=pointers_[2].that.getX();
				endY=pointers_[2].that.getY()+(pointers_[2].nodeHeight()/2)+4;
				cx1 = that.getX();
				cx2 = endX+15;
				cy1 = endY+90;
				cy2 = endY+90;
				noFill();
				bezier(that.getX()+15,topY+63, cx1,cy1,cx2,cy2,  endX,endY);
  				tx = bezierTangent(that.getX()+15, cx1,cx2, endX, 1);
 				ty = bezierTangent(topY+63, cy1,cy2, endY, 1);
	 			a=atan2(ty,tx);
 				a+=PI/2;
				fill(nextColour_);
				push();
				translate(endX,endY);
				rotate(a);
  				triangle(-4,4,4,4,0,-4);
				pop();
			}
		}

	}
	that.drawStable=function(){
		that.drawNode();
		var i;
		for(i=0;i<numLabels_;i++){
			that.drawNext(i);
		}
	}

	that.drawChangeNext=function(idx){

		drawNode();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
		if(frame < 1 && pointers_[idx]!=null){
			var i;
			for(i=0;i<numLabels_;i++){
				if(i!=idx){
					drawNext(i);
				}
			}
			var topY = that.getY()-that.nodeHeight()/2;
			var endX,endY;
			var cx1,cx2;
			var cy1,cy2;
			var tx,ty;
			var a;
			var px,py;
			var sx,sy;
			sx=that.getX()+15;
			if(idx == 0){
				sy=topY+13;
				if(pointers_[0] !=null){

					//first pointer always points to top of a node
					endX=pointers_[0].that.getX();
					endY=pointers_[0].that.getY()-(pointers_[0].nodeHeight()/2);
  					cx1 = that.getX();
					cx2 = endX+15;
					cy1 = endY-30;
					cy2 = endY-30;

					px =bezierPoint(that.getX()+15,cx1,cx2, endX, 0);
  					py = bezierPoint(topY+13, cy1,cy2, endY, 0);
	  				tx = bezierTangent(that.getX()+15, cx1,cx2, endX, 1);
	 				ty = bezierTangent(topY+13, cy1,cy2, endY, 1);
		 			a=atan2(ty,tx);
 					a+=PI/2;
				}
			}
			else if(idx == 1){
				sy=topY+38;
				if(pointers_[1] !=null){
					if(numLabels_ == 2){
						endX=pointers_[1].that.getX();
						endY=pointers_[1].that.getY()+(pointers_[1].nodeHeight()/2)+4;
						cx1 = that.getX();
						cx2 = endX+15;
						cy1 = endY+90;
						cy2 = endY+90;
						sy=topY+38;
					}
					else{
						endX=pointers_[1].that.getX() - (pointers_[1].nodeWidth_/2)-2;
						endY=pointers_[1].that.getY()-(pointers_[1].nodeHeight()/2)+10;
						cx1 = that.getX()+(endX-that.getX())/2;
						cx2 = that.getX()+(endX-that.getX())/2;
						cy1 = endY-10;
						cy2 = endY-10;
					}
					px =bezierPoint(that.getX()+15,cx1,cx2, endX, 0);
  					py = bezierPoint(topY+38, cy1,cy2, endY, 0);
  					tx = bezierTangent(that.getX()+15, cx1,cx2, endX, 1);
 					ty = bezierTangent(topY+38, cy1,cy2, endY, 1);
 					a=atan2(ty,tx);
 					a+=PI/2;
				}
			}
			else if(idx==2){
				sy=topY+63;
				if(pointers_[2] !=null){
					endX=pointers_[2].that.getX();
					endY=pointers_[2].that.getY()+(pointers_[2].nodeHeight()/2)+4;
					cx1 = that.getX();
					cx2 = endX+15;
					cy1 = endY+90;
					cy2 = endY+90;

					px = bezierPoint(that.getX()+15,cx1,cx2, endX, 0);
  					py = bezierPoint(topY+63, cy1,cy2, endY, 0);
  					tx = bezierTangent(that.getX()+15, cx1,cx2, endX, 1);
 					ty = bezierTangent(topY+63, cy1,cy2, endY, 1);
	 				a=atan2(ty,tx);
 					a+=PI/2;
				}
			}
			stroke(nextColour_);
			fill(nextColour_);
			ellipse(sx,sy,5,5);
			noFill();

			for(i=1;i<frame*1000;i++){
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
		 	push();
		  	translate(cx,cy);
			rotate(a);
 			triangle(-4,4,4,4,0,-4);
			pop();
		}
		else{
			state_=STABLE;
			for(i=0;i<numLabels_;i++){
				drawNext(i);
			}
			ai_.setCompleted(true);
		}
	}
	that.drawBreakNext=function(idx){

		drawStable();
		var currTime=millis();
		var frame = (currTime-stateStartTime_)/animationDuration_;
		var topY = that.getY()-that.nodeHeight()/2;
		if(frame < 1){
			var endX,endY;
			var cx1,cx2;
			var cy1,cy2;
			var tx,ty;
			var a;
			var px,py;
			var sx,sy;
			sx=that.getX()+15;

			if(idx == 0){
				sy=topY+13;
				if(pointers_[0] !=null){
					//first pointer always points to top of a node
					endX=pointers_[0].that.getX();
					endY=pointers_[0].that.getY()-(pointers_[0].nodeHeight()/2);
  					cx1 = that.getX();
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
						endX=pointers_[1].that.getX();
						endY=pointers_[1].that.getY()+(pointers_[1].nodeHeight()/2)+4;
						cx1 = that.getX();
						cx2 = endX+15;
						cy1 = endY+90;
						cy2 = endY+90;
					}
					else{
						endX=pointers_[1].that.getX() - (pointers_[1].nodeWidth()/2)-2;
						endY=pointers_[1].that.getY()-(pointers_[1].nodeHeight()/2)+10;
						cx1 = that.getX()+(endX-that.getX())/2;
						cx2 = that.getX()+(endX-that.getX())/2;
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
					endX=pointers_[2].that.getX();
					endY=pointers_[2].that.getY()+(pointers_[2].nodeHeight()/2)+4;
					cx1 = that.getX();
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
			push();
	 		translate(px,py);
			rotate(a);
  			line(-8,-8,8,8);
  			line(-8,8,8,-8);
			pop(); 			
		}
		else{
			setNext(null,idx);
			ai_.setCompleted(true);
		}
	}
	that.draw=function(){

		switch (state_){
			case STABLE:
				that.drawStable(); break;
			case MOVELOCATION:
				that.drawMove(); break;
			case CHANGENEXT:
				that.drawChangeNext(ptrIdx_); break;
			case BREAKNEXT:
				that.drawBreakNext(ptrIdx_); break;

		}
	}
	return that;
}
