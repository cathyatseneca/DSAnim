class Code{
  String [] lines_;
  int cap_;
  int sz_;
  int highlighter_;
  int posX_;
  int posY_;
  int lineHeight_;
  int codeWidth_;
  PFont font_;
  Code(int numLines){
    font_=createFont("Courier", 12);
    lines_=new String[numLines];
    cap_=numLines;
    sz_=0;
    highlighter_=1;
    posX_=100;
    posY_=100;
    lineHeight_=14;
    codeWidth_=300;
  }
  void setPos(int x,int y){
    posX_=x;
    posY_=y;
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
  void draw(){
    pushStyle();
    textFont(font_);
    textAlign(LEFT);
    fill(#FFFFFF);
    stroke(#000000);
    rect(posX_,posY_,codeWidth_,sz_*lineHeight_+10);
    fill(#FFFF99);
    stroke(#FFFFFF);
    rect(posX_+5,posY_+(highlighter_*lineHeight_+lineHeight_/4),codeWidth_-10,lineHeight_);
    fill(#000000);
    for(int i=0;i<sz_;i++){
      text(lines_[i],posX_+10,posY_+((i+1)*lineHeight_));
    }
    popStyle();
  }
 }
