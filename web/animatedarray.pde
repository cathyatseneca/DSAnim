class AnimatedArray extends AnimationObject{
	int [] data_;
	boolean [] isEmpty_;
	color [] dataColours_;
	color [] squareColours_;
	int cap_;
	int sz_;
	int state_;
	int sqsz_;
	int to_;
	int from_;
	float stateStartTime_;
	float animationDuration_;
	AnimationInstruction ai_;
	AnimatedArray(int [] data,int sz){
		super(120,120);
		cap_=MAXARRAY;
		sz_=sz;
		sqsz_=30;
		data_ = new int [cap_];
		isEmpty_= new boolean[cap_];
		dataColours_=new color[cap_];
		squareColours_=new color[cap_];
		state_=STABLE;
		animationDuration_=2000;   //2000 millis = 2 sec
		for(int i=0;i<sz;i++){
			data_[i]=data[i];
			dataColours_[i]=color(0);
			squareColours_[i]=color(255);
			isEmpty_[i]=false;
		}
		for(int i=sz_;i<cap_;i++){
			data_[i]=0;
			dataColours_[i]=color(0);
			squareColours_[i]=color(255);
			isEmpty_[i]=true;
		}
	}
	AnimatedArray(int cap){
		super(120,120);
		cap_=cap;
		sz_=cap;
		sqsz_=30;
		data_ = new int [cap_];
		isEmpty_= new boolean[cap_];
		dataColours_=new color[cap_];
		squareColours_=new color[cap_];
		state_=STABLE;
		animationDuration_=2000;   //2000 millis = 2 sec
		for(int i=0;i<cap_;i++){
			dataColours_[i]=color(0);
			squareColours_[i]=color(255);
			isEmpty_[i]=true;
		}
		fillRandom();
	}
	void process(AnimationInstruction ai){
		ai_=ai;
		switch(ai.instruction_){
			case SWAP:
				state_=SWAP;
				from_=ai.a_;
				to_=ai.b_;
				stateStartTime_=millis();
				break;
		}
	}
	void drawStable(){
		for(int i=0;i<sz_;i++){
			if(data_[i] > 0){
				drawSqWithNum(data_[i],dataColours_[i],squareColours_[i],sqsz_,x_+i*sqsz_,y_);
			}
			else{
				drawSquare(sqsz_,squareColours_[i],x_+i*sqsz_,y_);
			}
		}
	}
	void drawSwap(){
		float currTime=millis();
		if(currTime - stateStartTime_ < animationDuration_){
	    	for(int i=0;i<sz_;i++){
    	    	if(i==to_ || i==from_){
        	  		drawSquare(sqsz_,squareColours_[i],x_+i*sqsz_,y_);
        		}
       			else{
          			drawSqWithNum(data_[i],dataColours_[i],squareColours_[i],sqsz_,x_+i*sqsz_,y_);
        		}
	      	}
	      	float t=(currTime-stateStartTime_)/animationDuration_;
	      	float start = x_+(from_+0.5)*sqsz_;
	      	float end = x_+(to_+0.5)*sqsz_;
	      	float half= (start+end)/2;
	      	float height=100;
	      	float x=bezierPoint(start,half,half,end,t);
	      	float y=bezierPoint(y_+(sqsz_*0.5),y_-height,y_-height,y_+(sqsz_*0.5),t);
	      	fill(dataColours_[from_]);
	      	text(data_[from_],x,y);	

	      	x=bezierPoint(end,half,half,start,t);
	      	y=bezierPoint(y_+(sqsz_*0.5),y_+height,y_+height,y_+(sqsz_*0.5),t);
	      	fill(dataColours_[to_]);
	      	text(data_[to_],x,y);
	    }
	    else{
	    	int tmp=data_[to_];
	    	data_[to_]=data_[from_];
	    	data_[from_]=tmp;
	    	ai_.setCompleted(true);
	    	state_=STABLE;
	    }
	}
	void draw(){
		switch(state_){
			case STABLE:
				drawStable(); break;
			case SWAP:
				drawSwap(); break;
		}
	}
	void fillRandom(){
    	for(int i=0;i<cap_;i++){
      		data_[i]=int(random(1,99));
    	}
   		sz_=cap_;
  	}
};