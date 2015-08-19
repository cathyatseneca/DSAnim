var AnimatedCode = function(spec){
	var that = AnimationObject (spec);
	var lines_ = spec.code;
	var highlighterStart_ = 1;
	var highlighterEnd_=1;
	var lineHeight_=14;
	var codeWidth_=300;
	var isVisible_=true;
	var font_="Courier";
	var bgColour_ = spec.bgColour;
	var fontColour_ = spec.fontColour;
	var hlColour_ = spec.hlColour;

	if(bgColour_ == undefined){
		bgColour_=color(255);
	}
	if(fontColour_==undefined){
		fontColour_=color(0);
	}
	if(hlColour_==undefined){
		hlColour_=color(goldColour)
	}

	that.setWidth=function(w){
		width_=w;
	}
	that.appendCode=function(s){
		lines_.append(s);
	}
	that.setLineHeight=function(lh){
		lineHeight_=lh;
	}
	that.setHighLighter = function (params){
		if(params.ln <= lines_.length){
			highlighterStart_=params.ln-1;
			highlighterEnd_=params.ln-1;
		}
	}
	that.setBGColour = function (c){
		bgColour_=c;
	}
	that.setHighLighterColour = function(c){
		hlColour_=c;
	}
	that.setFontColour = function(c){
		fontColour_=c;
	}

	that.setMultiHighLighter = function (params){
		if(params.sln <= lines_.length && params.eln <= lines_.length){
			highlighterStart_=params.sln-1;
			highlighterEnd_=params.eln-1;
		}
	}
	that.setVisibility = function (vis){
		isVisible_=vis;
	}
	that.hide = function (){
		isVisible_=false;
	}
	that.show = function (){
		isVisible_=true;
	}
	that.isVisible = function (){
		return isVisible_;
	}
	that.process = function(ai){
		ai.instruction();
		ai.setCompleted(true);
	}
	that.draw = function(){
		if(isVisible_){
			push();
			textFont(font_);
            textAlign(LEFT);
            fill(bgColour_);
            stroke(bgColour_);
            rect(that.getX(),that.getY(),codeWidth_,lines_.length*lineHeight_+10);
            fill(hlColour_);
            stroke(hlColour_);
            if(highlighterStart_!=-1){
                for(var i=highlighterStart_; i<= highlighterEnd_;i++){
                    rect(that.getX()+5,that.getY()+(i*lineHeight_+lineHeight_/4),codeWidth_-10,lineHeight_);
                }
            }
            stroke(bgColour_); 
            fill(fontColour_);
            for(var i=0;i<lines_.length;i++){
                text(lines_[i],that.getX()+10,that.getY()+((i+1)*lineHeight_));
            }
            pop();
        }

	}
	return that;

}