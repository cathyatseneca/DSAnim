
class Animation{
	AnimationObject [] objects_;
	AnimationStep [] steps_;
	int currStep_;
	int numSteps_;
	int numObjects_;
	int height_;
	int width_;
	int capacity_;
	int animationState_;
	int animationMode_;
	float minimumDuration_;
	float stepStart_;
	color bgColour_;

	Animation(int width, int height){
		width_=width;
		height_=height;
		currStep_=0;
		numSteps_=0;
		steps_=new AnimationStep[MAXSTEPS];
		capacity_=MAXOBJECTS;
		objects_=new AnimationObject[capacity_];
		numObjects_=0;
		animationState_=PAUSED;
		animationMode_=CONTINUOUS;
		minimumDuration_=250;  //1000 millisecond minimum duration
		stepStart_=millis();
		bgColour_=color(30,60,90);
	}
	void setColour(color c){
		bgColour_=c;
	}
	void setMode(int mode){
		animationMode_=mode;
	}
	void setState(int state){
		animationState_=state;
		if(animationState_==PAUSED){
			noLoop();
		}
		else{
			loop();
			stepStart_=millis();
		}
	}
	void toggleState(){
		animationState_=(animationState_==PAUSED)?RUNNING:PAUSED;
		if(animationState_==PAUSED){
			noLoop();
		}
		else{
			loop();
			stepStart_=millis();
		}
	}
	int addObject(AnimationObject ao){
		int rc=-1;
		if(numObjects_ < capacity_){
			objects_[numObjects_]=ao;
			rc=numObjects_;
			numObjects_++;
		}
		return rc;
	}
	boolean addStep(){
		boolean rc=false;
		if(numSteps_ < MAXSTEPS){
			steps_[numSteps_]=new AnimationStep();
			numSteps_++;
			rc=true;
		}
		return rc;
	}
	boolean addToStep(int stepNumber,int objectId,int instruction, int a){
		boolean rc=false;
		if((stepNumber>=0 && stepNumber<numSteps_) && (objectId >= 0 && objectId < numObjects_)){
			steps_[stepNumber].add(objectId, instruction, a);
			rc=true;
		}
		return rc;
	}
	boolean addToStep(int stepNumber,int objectId,int instruction, int a,int b){
		boolean rc=false;
		if((stepNumber>=0 && stepNumber<numSteps_) && (objectId >= 0 && objectId < numObjects_)){
			steps_[stepNumber].add(objectId, instruction, a,b);
			rc=true;
		}
		return rc;
	}
	boolean addToStep(int stepNumber,int objectId,int instruction, int a,int b,int c){
		boolean rc=false;
		if((stepNumber>=0 && stepNumber<numSteps_) && (objectId >= 0 && objectId < numObjects_)){
			steps_[stepNumber].add(objectId, instruction, a,b,c);
			rc=true;
		}
		return rc;
	}
	boolean addToStep(int stepNumber,int objectId,int instruction, int a,int b,int c,int d){
		boolean rc=false;
		if((stepNumber>=0 && stepNumber<numSteps_) && (objectId >= 0 && objectId < numObjects_)){
			steps_[stepNumber].add(objectId, instruction, a,b,c,d);
			rc=true;
		}
		return rc;
	}
	boolean addToStep(int stepNumber,int objectId,int instruction, int a,int b,int c,int d,int e){
		boolean rc=false;
		if((stepNumber>=0 && stepNumber<numSteps_) && (objectId >= 0 && objectId < numObjects_)){
			steps_[stepNumber].add(objectId, instruction, a,b,c,d,e);
			rc=true;
		}
		return rc;
	}
	boolean addInstruction(int objectId,int instruction, int a){
		return addToStep(numSteps_-1, objectId, instruction, a);
	}
	boolean addInstruction(int objectId,int instruction, int a,int b){
		return addToStep(numSteps_-1, objectId, instruction, a,b);
	}
	boolean addInstruction(int objectId,int instruction, int a,int b,int c){
		return addToStep(numSteps_-1, objectId, instruction, a,b,c);
	}

	boolean addInstruction(int objectId,int instruction, int a,int b,int c,int d){
		return addToStep(numSteps_-1, objectId, instruction, a,b,c,d);
	}
	boolean addInstruction(int objectId,int instruction, int a,int b,int c,int d,int e){
		return addToStep(numSteps_-1, objectId, instruction, a,b,c,d,e);
	}
	void start(){
		for(int i=0;i<steps_[currStep_].numInstructions_;i++){
			int id = steps_[currStep_].instructions_[i].objectId_;
			objects_[id].process(steps_[currStep_].instructions_[i]);
		}
		setState(RUNNING);
	}
	void dump(){
		noLoop();
		println("capacity: " + capacity_);
		println("animationState_: " + animationState_);
		println("animationMode_: " + animationMode_);
		println("numSteps_: " + numSteps_);
		println("currStep: " + currStep_);
		for(int i=0;i<numSteps_;i++){
			println("step # "+ i);
			steps_[i].dump();
		}

	}
	void restart(){
		currStep_=0;
		for(int i=0;i<numObjects_;i++){
			objects_[i].restart();
		}
		for(int i=0;i<numSteps_;i++){
			steps_[i].restart();
		}
		animationState_=PAUSED;
		animationMode_=CONTINUOUS;
		minimumDuration_=250;  //1000 millisecond minimum duration
		stepStart_=millis();
		start();
	}
	void draw(){
		if(animationMode_ == CONTINUOUS){
			if(animationState_!=PAUSED){
				if(currStep_ < numSteps_){
					background(bgColour_);
					for(int i=0;i<numObjects_;i++){
						objects_[i].draw();
					}
					float currTime=millis();
					//println(currTime-stepStart_);
					if(steps_[currStep_].isCompleted() && (currTime-stepStart_) >= minimumDuration_){
						currStep_++;
						for(int i=0;i<steps_[currStep_].numInstructions_;i++){
							int id = steps_[currStep_].instructions_[i].objectId_;
							objects_[id].process(steps_[currStep_].instructions_[i]);
						}
						stepStart_=millis();
					}
				//println(currStep_ + " " + numSteps_);
				}
				else{
					setState(PAUSED);
				}
			}
		}
		else{
			if(currStep_ < numSteps_){
				if(animationState_!=PAUSED){
					background(bgColour_);
					for(int i=0;i<numObjects_;i++){
						objects_[i].draw();
					}
					float currTime=millis();
					//println(currTime-stepStart_);
					if(steps_[currStep_].isCompleted() && (currTime-stepStart_) >= minimumDuration_){
						currStep_++;
						for(int i=0;i<steps_[currStep_].numInstructions_;i++){
							int id = steps_[currStep_].instructions_[i].objectId_;
							objects_[id].process(steps_[currStep_].instructions_[i]);
						}
						stepStart_=millis();
						setState(PAUSED);
					}
				}
			//println(currStep_ + " " + numSteps_);
			}
			else{
				setState(PAUSED);
			}
		}
	}

};