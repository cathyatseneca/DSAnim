var AnimatedText = function (spec){
    var that = AnimationObject(spec);
    var text_ = spec.str || "";
    var isVisible_= spec.isVisible || false;
    var font_ ="courier";
    var colour_ = spec.colour || whiteColour;
    var stateStartTime_;
    var pauseDuration_;
    var ai_;

    that.show=function(){
        isVisible_=true;
        ai_.setCompleted(true);
    }
    that.hide = function(){
        isVisible_=false;
        ai_.setCompleted(true);
    }
    that.changeText = function(params){
        text_=params.str;
        ai_.setCompleted(true);
    }
    that.pause = function(params){
        pauseDuration_=params.duration;
        stateStartTime_=millis();
        ai_.setCompleted(false);
    }
    that.process = function(ai){
        ai_=ai;

        ai.instruction();
    }
    that.isVisible = function(){
        return isVisible_;
    }
    that.draw = function(){
            
        if(isVisible_){
            push();
            textFont(font_);
            textAlign(CENTER);
            fill(colour_);
            text(text_,that.getX(),that.getY());
            pop();
        }
        if(pauseDuration_ > 0){
            var elapsedTime=millis() - stateStartTime_;
            if(pauseDuration_ < elapsedTime){
                ai_.setCompleted(true);
                pauseDuration_=0;
            }           
        }
    }
    return that;
}