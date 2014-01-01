class AnimatedCode extends AnimationObject{
    String [] lines_;
    int cap_;
    int sz_;
    int highlighter_;
    int lineHeight_;
    int codeWidth_;
    PFont font_;
    AnimatedCode(String filename,int x,int y){
        super(x,y);
        font_=createFont("Courier", 12);
        lines_=loadStrings(filename);
        cap_=lines_.length;
        sz_=lines_.length;
        highlighter_=1;
        lineHeight_=14;
        codeWidth_=300;

    } 
    void setWidth(int w){
        codeWidth_=300;
    }
    void append(String s){
        lines_[sz_]=s;
        sz_++;
    }
    void setLineHeight(int lineHeight){
        lineHeight_=lineHeight;
    }
    void setHighLighter(int ln){
        if(ln<=sz_)
            highlighter_=ln-1;
    }
    void process(AnimationInstruction ai){
        setHighLighter(ai.a_);
        ai.setCompleted(true);
    }
    void draw(){
        pushStyle();
        textFont(font_);
        textAlign(LEFT);
        fill(#FFFFFF);
        stroke(#000000);
        rect(x_,y_,codeWidth_,sz_*lineHeight_+10);
        fill(#FFFF99);
        stroke(#FFFFFF);
        rect(x_+5,y_+(highlighter_*lineHeight_+lineHeight_/4),codeWidth_-10,lineHeight_);
        fill(#000000);
        for(int i=0;i<sz_;i++){
            text(lines_[i],x_+10,y_+((i+1)*lineHeight_));
        }
        popStyle();
    }
};
