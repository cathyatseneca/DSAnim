
var AnimationStep = function(spec){
	var that = {};
	var instructions_ = [];
	var isCompleted_=false;

	that.restart = function(){
		isCompleted_=false;
		for (var i=0;i<instructions_.length;i++){
			instructions_[i].restart();
		}
	}
	that.add = function(obj,instruction,params){
		instructions_.push(AnimationInstruction({ obj_:obj,
												  instruction_:instruction,
												  params_:params}));
	}
	that.instruction = function(idx){
		return instructions_[idx];
	}
	that.numInstructions = function(){
		return instructions_.length;
	}
	that.isCompleted = function(){
		var i;
		var numCompleted=0;
		for(var i=0;i<instructions_.length;i++){
			if(instructions_[i].isCompleted()){
				numCompleted++;
			}
		}
		return (numCompleted==instructions_.length);
	}
	return that;
}
var AnimationInstruction = function(spec){
	var that={};
	var instruction_=spec.instruction_;
	var drawnObject_=spec.obj_;
	var params_=spec.params_;
	var isCompleted_=false;

	that.restart = function(){
		isCompleted_=false;
	}
	that.isCompleted = function(){
		return isCompleted_;
	}
	that.setCompleted = function(c){
		isCompleted_=c;
	}
	that.drawnObject = function(){
		return drawnObject_;
	}
	that.instruction = function(){
		instruction_(params_)
	}
	return that;
}
var AnimationObject = function (spec){
	var that = {};
	var isStopped_ = spec.isStopped;
	var x_= spec.x || 0;
	var y_= spec.y || 0;
	var objectId_=spec.id;
	that.stop = function(){
		isStopped_=true;
	};
	that.start = function(){
		isStopped_=false;
	};
	that.setPosition = function(x,y){
		x_=x;
		y_=y;
	}
	that.setID = function(id){
		objectId_=id;
	}
	that.getX = function(){
		return x_;
	}
	that.getY = function(){
		return y_;
	}
	that.changeSpeed = function(speed){
	}
	that.restart = function() {

	}

	return that;
}
var Animation = function (spec){
	var that = {};
	var drawnObjects_ = [];
	var steps_ = []
	var currStep_=0;
	var height_=spec.height ||450;
	var width_=spec.width ||950 ;
	var isPaused_ = true;
	var isContinuous_ = true;
	var bgColour_;
	var minDuration_= spec.minDuration || 250;
	var stepStart_;

	that.setBGColour=function(c){
		bgColour_=c;
	};
	that.changeSpeed = function(s){
		minDuration_= 50 * s;
		for(var i=0;i<drawnObjects_.length;i++){
			drawnObjects_[i].changeSpeed(s);
		}
	};
	that.setContinuous = function(m){
		isContinuous_= m;
	};
	that.setPaused = function(p){
		isPaused_ = p;
		if(isPaused_ == true){
			noLoop();
		}
		else{
			loop();
			stepStart_ = millis();
		}
	};
	that.addObject = function (ao){
		drawnObjects_.push(ao);
		ao.setID(drawnObjects_.length);
	};
	that.addStep = function(){
		steps_.push(AnimationStep({}));
	};
	that.addInstruction = function(obj,instruction,params){
		steps_[steps_.length-1].add(obj,instruction,params)
	};
	that.start = function(){
		if (steps_.length > 0 ){
			for(var i=0;i<steps_[currStep_].numInstructions();i++){
				var obj = steps_[currStep_].instruction(i).drawnObject();
				obj.process(steps_[currStep_].instruction(i));
			}
		}
		stepStart_=millis();
		isPaused_=false;
	};
	that.isPaused = function(){
		return isPaused_;
	}
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
		that.start();
	};
	that.draw = function(){
		var i;
		var id;
		var currTime;
		if(steps_.length > 0){
			if(isContinuous_){
				if(!isPaused_){
					if(currStep_ < steps_.length){
						background(bgColour_);
						for(i=0;i<drawnObjects_.length;i++){
							drawnObjects_[i].draw();
						}
						currTime = millis();
						if (steps_[currStep_].isCompleted() && (currTime - stepStart_) >= minDuration_){
							currStep_++;
							if(currStep_ < steps_.length){
								for(i=0;i<steps_[currStep_].numInstructions();i++){
									obj = steps_[currStep_].instruction(i).drawnObject();
									obj.process(steps_[currStep_].instruction(i));
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
				if(currStep_ < steps_.length){
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
									obj=steps_[currStep_].instruction(i).drawnObject();
									obj.process(steps_[currStep_].instruction(i));
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
		else{
			background(bgColour_);
			for(i=0;i<drawnObjects_.length;i++){
				drawnObjects_[i].draw();
			}
			isPaused_=true;
		}
	};

	return that;
}