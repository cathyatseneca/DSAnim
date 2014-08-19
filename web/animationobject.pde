class AnimationObject{
	boolean isStopped_;
	int x_;
	int y_;
	AnimationObject(int x,int y){
		isStopped_=true;
		x_=x;
		y_=y;
	}
	void stop(){
		isStopped_=true;
	}
	void start(){
		isStopped_=false;
	}
	void setPosition(int x,int y){
		x_=x;
		y_=y;
	}
	void dump(){
		println(isStopped_?"stopped":"going");
		println("position: "+ x_ + ", " + y_);
	}
	void draw(){
	}
	void process(AnimationInstruction ai){
		
	}
	void restart(){
		
	}
};