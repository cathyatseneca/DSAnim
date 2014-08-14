/*this class draws a horizontal arrow with a split down the middle
and labels at both ends.*/

class AnimatedVariable extends AnimationObject{
	int value_;
	int initial_;
	color textColour_;
	color bgColour_;
	int size_;
	int isEmpty_;

	AnimatedVariable(int v, int size, int x, int y){
		super(x,y);
		value_=v;
		size_=size;
		initial_=v;
		textColour_=color(0);
		bgColour_=color(255);
		isEmpty_=1;

	}
	void setEmpty(int e){
		isEmpty_=e;
	}
	void process(AnimationInstruction ai){
		switch(ai.instruction_){
			case SET:
				value_=ai.a_;
				ai.setCompleted(true);
				break;
			case SETFONTCOLOUR:
				textColour_=color(ai.a_,ai.b_,ai.c_);
				ai.setCompleted(true);
				break;
			case SETBGCOLOUR:
				bgColour_=color(ai.a_,ai.b_,ai.c_);
				ai.setCompleted(true);
				break;
			case SETEMPTY:
				setEmpty(ai.a_);
				ai.setCompleted(true);
				break;
		}
	}
	void restart(){
		value_=initial_;
		textColour_=color(0);
		bgColour_=color(255);
		isEmpty_=1;
	}
	void draw(){
    	if(isEmpty_==0){
    		drawSqWithNum(value_,textColour_,bgColour_,size_,x_,y_);
	    }
    	else{
    		drawSquare(size_,bgColour_, x_, y_);
    	}
	}

}