var AnimationInstruction = function(spec){
	var that={};
	var instruction_;
	var objectId_;
	var params_;
	var isCompleted_;


	return that;
}
var AnimationStep = function(spec){

}
var AnimationObject = function (spec){
	var that = {};
	that.stop = function(){
		spec.isStopped_=true;
	};
	that.start = function(){
		spec.isStopped_=false;
	};
	that.setPosition = function(x,y){
		spec.x_=x;
		spec.y_=y;
	}
	that.setID = function(id){
		spec.id_=id;
	}
	that.getX = function(){
		return spec.x_;
	}
	that.getY = function(){
		return spec.y_;
	}
	return that;
}
var Animation = function (spec){
	var that = {};
	var drawnObjects_ = [];
	var steps_ = []
	var currStep_=0;
	var height_;
	var width_;
	var isPaused_ = true;
	var isContinuous_ = true;
	var bgColour_;
	var minDuration_=250;
	var stepStart_;

	that.setColour=function(c){
		bgColour_=c;
	};
	that.changeSpeed = function(s){
		minDuration_=50*s;
	};
	that.setContiuous = function(m){
		isContinuous_=s;
	};
	that.setPaused = function(p){
		isPaused_=p;
		if(isPaused_==true){
			noLoop();
		}
		else{
			loop();
			stepStart_=millis();
		}
	};
	that.addObject = function (ao){
		drawnObjects_.push(ao);
	};
	that.addStep = function(){

	};
	that.addInstruction = function(objectId,instruction,params){

	};
	that.start = function(){
		if (steps_.length > 0 ){
			//process instructions on current step.
		}
		isPaused_=false;
	};
	that.restart = function(){
		var i;
		currStep_=0;
		for(i=0;i<drawnObjects_.length;i++){
			drawnObjects_[i].restart();
		}
		for(i=0;i<steps_.length;i++){
			steps_[i].restart();
		}
		isPaused_=true;
		isContinuous_=true;
		minDuration_=250;
		stepStart_=millis();
		start();
	};
	that.draw = function(){
		var i;
		var id;
		var currTime;
		if(steps_.length > 0){
			if(isContinuous_==true){
				if(isPaused_==false){
					if(currStep_ < steps_.length){
						background(bgColour_);
						for(i=0;i<drawnObjects_.length;i++){
							drawnObjects_[i].draw();
						}
						currTime = millis();
						if(steps_[currStep_].isCompleted() && (currTime - stepStart_) >= minDuration_){
							currStep_++;
							if(currStep_ < steps_.length){
								for(i=0;i<steps_[currStep_].numInstructions();i++){
									id = steps_[currStep_].instructions_[i].objectId();
									drawnObjects_[i].process(steps_[currStep_].instructions_[i]);
								}
								stepStart_=millis();
							}
						}
					}
					else{
						isPaused_=true;
					}
				}
			}
			else{
				if(currStep_ < steps.length){
					if(isPaused_==false){
						background(bgColour_);
						for( i=0;i<drawnObjects_.length;i++){
							drawnObjects_[i].draw();
						}
						currTime=millis();
						if(steps_[currStep_].isCompleted() && (currTime-stepStart_)>=minDuration_){
							currStep_++;
							if(currStep_<steps_.length){
								for(i=0;i<steps_[currStep_].numInstructions();i++){
									id=steps_[currStep_].instructions_[i].objectId();
									drawnObjects_[id].process(steps_[currStep_].instructions_[i]);
								}
								stepStart_=millis();
								isPaused_=true;
							}
						}
					}
				}
				else{
					isPaused_=true;
				}

			}
		}
	};

	return that;
}