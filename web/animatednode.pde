class AnimatedNode extends AnimationObject{
	int data_;
	AnimatedNode next_;
	AnimatedNode prev_;
	color bgColour_;
	color fontColour_;
	float stateStartTime_;
	float animationDuration_;
	int state_;

	AnimatedNode(int v, int x, int y){
		super(x,y);
		data_=v;
		next_=NULL;
		prev_=NULL;
		bgColour_=whiteColour;
		fontColour_=blueColour;
		state_=STABLE;
	}
	void drawStable(){
		pushStyle();
		rectMode(CENTER);
		fill(bgColour_);
		stroke(0);
		rect(x,y,50,100);
		fill(fontColour_);
		stroke(fontColour_);
		textAlign(CENTER);
		text(data_,x+25,y+25);
		ellipse(x+25,y+50);
		ellipse(x+25,y+100);
		popStyle();
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