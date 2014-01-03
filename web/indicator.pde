class Indicator extends AnimationObject{
	color indicatorColour_;
	String label_;
	int incrementSize_;
	int position_;        //position of pointy end
	boolean up_;
	int state_;

	Indicator(String label, color indicatorColour,int sz, int x, int y){
		super(x,y);
		indicatorColour_= indicatorColour;
		label_=label;
		incrementSize_=sz;
		position_=0;
		up_=true;
		state_=VISIBLE;
	}
	void setPosition(int pos){
		position_=pos;
	}
	void pointDown(){
		up_=false;
	}
	void setColour(color c){
		indicatorColour_=c;
	}
	void setVisibility(int v){
		state_=v;
	}
	void process(AnimationInstruction ai){
		switch(ai.instruction_){
			case SET:
			setPosition(ai.a_);
			ai.setCompleted(true);
			break;
			case SETVISIBILITY:
			setVisibility(ai.a_);
			ai.setCompleted(true);
			break;
		}
	}
	void draw(){
		if(state_!=HIDDEN){
			if(up_){
				drawTriangle(indicatorColour_,incrementSize_, x_+position_*incrementSize_,y_);
				textAlign(CENTER);
				text(label_,x_+position_*incrementSize_,y_+25);
			}
			else{
				drawDownTriangle(indicatorColour_,incrementSize_, x_+position_*incrementSize_,y_);
				textAlign(CENTER);
				text(label_,x_+position_*incrementSize_,y_-15);
			}
		}
	}


}