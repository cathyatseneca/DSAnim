
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
	that.add = function(objectId,instruction,params){
		instructions_.push(AnimationInstruction({ objectId_:objectId,
												  instruction_:instruction,
												  params_:params}));
	}
	that.instruction = function(idx){
		return instructions_[idx];
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
	var objectId_=spec.objectId_;
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
	that.objectId = function(){
		return objectsId_;
	}
	return that;
}
var AnimationObject = function (spec){
	var that = {};
	var isStopped_ = spec.isStopped;
	var x_= 0 || spec.x;
	var y_= 0 ||spec.y;
	id_=spec.id;
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
		id_=id;
	}
	that.getX = function(){
		return x_;
	}
	that.getY = function(){
		return y_;
	}
	return that;
}
var Animation = function (spec){
	var that = {};
	var drawnObjects_ = [];
	var steps_ = []
	var currStep_=0;
	var height_=450 || spec.height;
	var width_=950 || spec.width;
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
		steps_.push(AnimationStep({}));
	};
	that.addInstruction = function(objectId,instruction,params){
		steps_[steps_.length-1].add(objectId,instruction,params)
	};
	that.start = function(){
		if (steps_.length > 0 ){
			for(var i=0;i<steps_[currStep_].numInstructions();i++){
				var id = steps_[currStep_].instructions_[i].objectId();
				drawnObjects_[id].process(steps_[currStep_].instructions_[i]);
			}
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