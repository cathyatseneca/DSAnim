class Indicator extends AnimationObject{
	color indicatorColour_;
	String label_;
	int incrementSize_;
	int position_;

	Indicator(String label, color indicatorColour,int sz, int x, int y){
		super(x,y);
		indicatorColour_= indicatorColour;
		label_=label;
		incrementSize_=sz;
		position_=0;
	}
	void setPosition(int pos){
		position_=pos;
	}
	void process(AnimationInstruction ai){
		setPosition(ai.a_);
		ai.setCompleted(true);
	}

	void draw(){
		drawTriangle(indicatorColour_,incrementSize_, x_+position_*incrementSize_,y_);
	}


}