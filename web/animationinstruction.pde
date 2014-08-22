class AnimationInstruction{
	int objectId_;     //the id of the object in the instruction
	int instruction_;  //instruction number for the object
	int numParams_;
	int a_;
	int b_;
	int c_;
	int d_;
	int e_;
	String s_;
	boolean completed_;
	AnimationInstruction(int objectId,int instruction, int a){
		objectId_=objectId;
		instruction_=instruction;
		numParams_=1;
		a_=a;
		completed_=false;
	}
	AnimationInstruction(int objectId,int instruction, int a,int b){
		objectId_=objectId;
		instruction_=instruction;
		numParams_=2;
		a_=a;
		b_=b;
		completed_=false;
	}
	AnimationInstruction(int objectId,int instruction, int a,int b,int c){
		objectId_=objectId;
		instruction_=instruction;
		numParams_=3;
		a_=a;
		b_=b;
		c_=c;
		completed_=false;
	}
	AnimationInstruction(int objectId,int instruction, int a,int b,int c,int d){
		objectId_=objectId;
		instruction_=instruction;
		numParams_=3;
		a_=a;
		b_=b;
		c_=c;
		d_=d;
		completed_=false;
	}
	AnimationInstruction(int objectId,int instruction, int a,int b,int c,int d,int e){
		objectId_=objectId;
		instruction_=instruction;
		numParams_=3;
		a_=a;
		b_=b;
		c_=c;
		d_=d;
		e_=e;
		completed_=false;
	}
	void setCompleted(boolean completed){
		completed_=completed;
	}
	boolean isCompleted(){
		return completed_;
	}
	void restart(){
		completed_=false;
	}
}

class AnimationStep{
	AnimationInstruction [] instructions_;
	int numInstructions_;
	int maxInstructions_;
	boolean completed_;
	AnimationStep(){
		numInstructions_=0;
		maxInstructions_=MAXINSTRUCTIONS;
		instructions_=new AnimationInstruction[MAXINSTRUCTIONS];
		completed_=false;
	}

	AnimationStep(int maxInstructions){
		numInstructions_=0;
		maxInstructions_=maxInstructions;
		instructions_=new AnimationInstruction[maxInstructions];
		completed_=false;
	}
	void restart(){
		completed_=false;
		for(i=0;i<numInstructions_;i++){
			instructions_[i].restart();
		}
	}

	void add(int objectId, int instruction, int a){
		if(numInstructions_ < maxInstructions_){
			instructions_[numInstructions_] = new AnimationInstruction(objectId,instruction,a);
			numInstructions_++;
		}
	}	
	void add(int objectId, int instruction,int a,int b){
		if(numInstructions_ < maxInstructions_){
			instructions_[numInstructions_] = new AnimationInstruction(objectId,instruction,a,b);
			numInstructions_++;
		}
	}
	void add(int objectId, int instruction,int a,int b,int c){
		if(numInstructions_ < maxInstructions_){
			instructions_[numInstructions_] = new AnimationInstruction(objectId,instruction,a,b,c);
			numInstructions_++;
		}
	}
	void add(int objectId, int instruction,int a,int b,int c,int d){
		if(numInstructions_ < maxInstructions_){
			instructions_[numInstructions_] = new AnimationInstruction(objectId,instruction,a,b,c,d);
			numInstructions_++;
		}
	}
	void add(int objectId, int instruction,int a,int b,int c,int d,int e){
		if(numInstructions_ < maxInstructions_){
			instructions_[numInstructions_] = new AnimationInstruction(objectId,instruction,a,b,c,d,e);
			numInstructions_++;
		}
	}

	boolean isCompleted(){
		int i;
		int numCompleted=0;
		for(i=0;i<numInstructions_;i++){
			if(instructions_[i].isCompleted()){
				numCompleted++;
			}
		}
		if(numCompleted==numInstructions_){
			completed_=true;
		}
		else{
			completed_=false;
		}
		return completed_;
	}
	void dump(){
		println("numInstructions: " + numInstructions_);
		for(int i=0;i<numInstructions_;i++){
			println("  object: " + instructions_[i].objectId_);
			println("  instruction #: "+instructions_[i].instruction_);
			println("  # of parameters: " + instructions_[i].numParams_);
			println("  iscompleted : "+instructions_[i].isCompleted());
			println("  parameters:");
			switch(instructions_[i].numParams_){
				case 1:	println("a: "+ instructions_[i].a_); break;
				case 2:	println("a: "+ instructions_[i].a_ + " b: " + instructions_[i].b_); break;
				case 3:	println("a: "+ instructions_[i].a_ + " b: " + instructions_[i].b_ + " c: " + instructions_[i].c_); break;
			}

		}
	}
};