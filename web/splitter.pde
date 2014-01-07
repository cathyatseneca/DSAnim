/*this class draws a horizontal arrow with a split down the middle
and labels at both ends.*/

class Splitter extends AnimationObject{
	float unitSize_;
	int numUnits_;
	String leftLabel_;
	String rightLabel_;
	color leftColour_;
	color rightColour_;
	int position_;

	Splitter(String leftLabel,String rightLabel, color leftColour, color rightColour,int numUnits, float size, int x, int y){
		super(x,y);
		leftLabel_=leftLabel;
		rightLabel_=rightLabel;
		leftColour_=leftColour;
		rightColour_=rightColour;
		numUnits_ = numUnits;
		unitSize_=size;
		position_=0;
	}
	void setPosition(int pos){
		if(pos >=0 && pos <=numUnits_){
			position_=pos;
		}
	}
	void setNumUnits(int sz){
		numUnits_=sz;
	}
	void process(AnimationInstruction ai){
		switch(ai.instruction_){
			case SET:
				setPosition(ai.a_);
				ai.setCompleted(true);
				break;
			case CHANGESIZE:
				setNumUnits(ai.a_);
				ai.setCompleted(true);
			case CHANGEPOSITION:
				x_=ai.a_;
				y_=ai.b_;
				ai.setCompleted(true);

		}
	}
	void draw(){
		stroke(255);
		fill(255);
		float topX= x_+(position_*unitSize_);
		float topY= y_ + 5;
		float endpt= x_+(unitSize_*numUnits_);
		strokeWeight(3);
		line(topX,topY, topX, topY+30);
		strokeWeight(1);
		if(position_ !=0){
			pushStyle();
			textAlign(LEFT);
			text(leftLabel_,x_,topY);    
			popStyle();
			fill(leftColour_);
			stroke(leftColour_);
			line(x_,topY+15,topX-5,topY+15);
			triangle(x_,topY+15,x_+10,topY+10,x_+10,topY+20);
		}
		if(position_!=numUnits_){
			fill(#FFFFFF);
			stroke(#FFFFFF);
			text(rightLabel_,endpt,topY);    
			fill(rightColour_);
			stroke(rightColour_);
			line(topX+5,topY+15,endpt,topY+15);
			triangle(endpt,topY+15,endpt-10,topY+10,endpt-10,topY+20);
		}
	}
}