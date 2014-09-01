class AnimatedNode extends AnimationObject{
	int data_;
	AnimatedNode next_;
	AnimatedNode prev_;
	color bgColour_;
	color fontColour_;
	float stateStartTime_;
	float animationDuration_;
	int state_;

	Node(int v, int x, int y){
		super(x,y);
		data_=v;
		next_=NULL;
		prev_=NULL;
		bgColour_=whiteColour;
		fontColour_=blueColour;
	}
	void drawStable(){
	}
	void drawMove(){}
	void drawChangeNext(){}
	void drawChangePrev(){}
	void drawBreakNext(){}
	void drawBreakPrev(){}

	void draw(){
		switch (state_){
			case STABLE:
				drawStable(); break;
			case MOVE:
				drawMove(); break;
			case CHANGENEXT:
				drawChangeNext(); break;
			case CHANGEPREV:
				drawChangePrev(); break;
			case BREAKNEXT:
				drawBreakNext(); break;
			case BREAKPREV:
				drawBreakPrev(); break;

		}
	}
}