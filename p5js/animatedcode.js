var AnimatedCode = function(spec){
	var that = AnimationObject (spec);
	var lines_ = spec.code;
	var highlighterStart_ = 1;
	var varhighlighterEnd_=1;
	var lineHeight_=14
	var codeWidth_=300;
	var isVisible_=true;
	var font_="Courier";

	that.setWidth=function(w){
		width_=w;
	}
	that.appendCode=function(s){
		lines_.append(s);
	}
	that.setLineHeight=function(lh){
		lineHeight_=lh;
	}
	that.setHighLighter = function (ln){
		if(ln <= lines_.length){
			highlighterStart_=ln-1;
			highlighterEnd_=ln-1;
		}
	}
	that.setHighLighter = function (sln , eln){
		if(sln <= lines_.length && eln <= lines.length){
			highlighterStart_=sln-1;
			highlighterEnd_=eln-1;
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
		ai.instruction_(a1.param_);
	}
	that.draw = function(){
		if(isVisible_){
			pushStyle();
			textFont(font_);
            textAlign(LEFT);
            fill(backgroundColour);
            stroke(backgroundColour);
            rect(x_,y_,codeWidth_,sz_*lineHeight_+10);
            fill(pageButtonColour);
            stroke(pageButtonColour);
            if(highlighterStart_!=-1){
                for(var i=highlighterStart_; i<= highlighterEnd_;i++){
                    rect(x_+5,y_+(i*lineHeight_+lineHeight_/4),codeWidth_-10,lineHeight_);
                }
            } 
            fill(goldColour);
            for(var i=0;i<sz_;i++){
                text(lines_[i],x_+10,y_+((i+1)*lineHeight_));
            }
            popStyle();
        }

	}
	return that;

}