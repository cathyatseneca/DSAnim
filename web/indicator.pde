class Indicator extends AnimationObject{
	color indicatorColour_;
	String label_;
	int incrementSize_;
	int position_;        //position of pointy end
	boolean up_;
	int state_;
	int [] gap_;
	int initialPosition_;

	Indicator(String label, color indicatorColour,int sz, int x, int y){
		super(x,y);
		indicatorColour_= indicatorColour;
		label_=label;
		incrementSize_=sz;
		initialPosition_=0;
		position_=0;
		up_=true;
		state_=VISIBLE;
		gap_ = new int[30];
		for(int i=0;i<30;i++){
			gap_[i]=0;
		}
	}
	Indicator(String label, color indicatorColour,int initial, int sz, int x, int y){
		super(x,y);
		indicatorColour_= indicatorColour;
		label_=label;
		incrementSize_=sz;
		initialPosition_=initial;
		position_=initial;
		up_=true;
		state_=VISIBLE;
		gap_ = new int[30];
		for(int i=0;i<30;i++){
			gap_[i]=0;
		}
	}
	void restart(){
		position_=initialPosition_;
		for(int i=0;i<30;i++){
			gap_[i]=0;
		}
		//println("in indicator restart" );
		
	}
	void setIdx(int pos){
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
	void hide(){
		state_=HIDDEN;
	}
	void show(){
		state_=VISIBLE;
	}
	void process(AnimationInstruction ai){
		switch(ai.instruction_){
			case SET:
				setIdx(ai.a_);
				ai.setCompleted(true);
				break;
			case SETVISIBILITY:
				setVisibility(ai.a_);
				ai.setCompleted(true);
				break;
			case SETPOS:
				x_=ai.a_;
				y_=ai.b_;
				ai.setCompleted(true);
				break;
			case ADDGAP:
				for(int i=ai.a_+1;i<30;i++){
					gap_[i]+=(incrementSize_/2);
				}
				ai.setCompleted(true);
				break;
			case REMOVEGAP:
				for(int i=ai.a_+1;i<30;i++){
					gap_[i]-=(incrementSize_/2);
				}
				ai.setCompleted(true);
				break;
		}
	}
	void draw(){
		if(state_!=HIDDEN){
			if(up_){
				drawTriangle(indicatorColour_,incrementSize_, gap_[position_]+x_+position_*incrementSize_,y_);
				textAlign(CENTER);
				text(label_,gap_[position_]+x_+position_*incrementSize_,y_+25);
			}
			else{
				drawDownTriangle(indicatorColour_,incrementSize_,gap_[position_]+ x_+position_*incrementSize_,y_);
				textAlign(CENTER);
				text(label_,gap_[position_]+x_+position_*incrementSize_,y_-15);
			}
		}
	}


};