class AnimatedText extends AnimationObject{
    String text_;
    int state_;
    PFont font_;
    color colour_;
    float stateStartTime_;
    float pauseDuration_;
    AnimationInstruction ai_;

    AnimatedText(String s,int x,int y,int size,color c){
        super(x,y);
        font_=createFont("Courier", size);
        text_=s;
        state_=VISIBLE;
        colour_=c;
    } 
    void setVisibility(int vis){
        state_=vis;
    }
    void hide(){
        state_=HIDDEN;
    }
    void show(){
        state_=VISIBLE;
    }
    void changeText(String s){
        text_=s;
    }
    void process(AnimationInstruction ai){
        ai_=ai;
        switch(ai.instruction_){
            case SET:
                changeText(ai.s_);
                ai.setCompleted(true);
                break;
            case SETVISIBILITY:
                setVisibility(ai.a_);
                ai.setCompleted(true);
                break;
            case PAUSEANIM:
                stateStartTime_=millis();
                pauseDuration_=ai.a_;
                break;
        }
    }
    boolean isVisible(){
        return (state_==VISIBLE)?true:false;
    }
    void draw(){
            
        if(state_==VISIBLE){

            pushStyle();
            textFont(font_);
            textAlign(CENTER);
            fill(colour_);
            text(text_,x_,y_);
            popStyle();
        }
        if(pauseDuration_ > 0){
            float elapsedTime=millis() - stateStartTime_;
            if(pauseDuration_ < elapsedTime){
                ai_.setCompleted(true);
                pauseDuration_=0;
            }           
        }
    }
};
