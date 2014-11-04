class AnimatedCode extends AnimationObject{
    String [] lines_;
    int cap_;
    int sz_;
    int highlighterStart_;
    int highlighterEnd_;
    int lineHeight_;
    int codeWidth_;
    int state_;
    PFont font_;
    AnimatedCode(String filename,int x,int y){
        super(x,y);
        font_=createFont("Courier", 12);
        lines_=loadStrings(filename);
        cap_=lines_.length;
        sz_=lines_.length;
        highlighterStart_=1;
        highlighterEnd_=1;
        lineHeight_=14;
        codeWidth_=300;
        state_=VISIBLE;

    }
    AnimatedCode(int x,int y){
        super(x,y);
        font_=createFont("Courier", 12);
        lines_=new String[50];
        cap_=50;
        sz_=0;
        highlighterStart_=1;
        highlighterEnd_=1;
        lineHeight_=14;
        codeWidth_=300;
        state_=VISIBLE;

    } 
    void setWidth(int w){
        codeWidth_=w;
    }
    void append(String s){
        lines_[sz_]=s;
        sz_++;
    }
    void setLineHeight(int lineHeight){
        lineHeight_=lineHeight;
    }
    void setHighLighter(int ln){
        if(ln<=sz_){
            highlighterStart_=ln-1;
            highlighterEnd_=ln-1;
        }
    }
    void setHighLighter(int startLn, int endLn){
        if(startLn <= sz_){
            highlighterStart_=startLn-1;
            highlighterEnd_=endLn-1;
        }
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
    boolean isVisible(){
        boolean rc=true;
        if(state_==HIDDEN)
            rc=false;
    }
    void process(AnimationInstruction ai){
        switch(ai.instruction_){
            case SET:
                setHighLighter(ai.a_);
                ai.setCompleted(true);
                break;
            case SETRANGE:
                setHighLighter(ai.a_,ai.b_);
                ai.setCompleted(true);
                break;
            case SETVISIBILITY:
                setVisibility(ai.a_);
                ai.setCompleted(true);
                break;
        }
    }
    void draw(){
        if(state_==VISIBLE){
            pushStyle();
            textFont(font_);
            textAlign(LEFT);
            fill(backgroundColour);
            stroke(backgroundColour);
            rect(x_,y_,codeWidth_,sz_*lineHeight_+10);
            fill(pageButtonColour);
            stroke(pageButtonColour);
            if(highlighterStart_!=-1){
                for(int i=highlighterStart_; i<= highlighterEnd_;i++){
                    rect(x_+5,y_+(i*lineHeight_+lineHeight_/4),codeWidth_-10,lineHeight_);
                }
            } 
            fill(goldColour);
            for(int i=0;i<sz_;i++){
                text(lines_[i],x_+10,y_+((i+1)*lineHeight_));
            }
            popStyle();
        }
    }
};
