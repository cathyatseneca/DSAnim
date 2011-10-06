class Code{
  String [] lines;
  int cap;
  int sz;
  int highlighter;
  int posX;
  int posY;
  int lineHeight;
  int codeWidth;
  Code(int numLines){
    lines=new String[numLines];
    cap=numLines;
    sz=0;
    highlighter=1;
    posX=100;
    posY=100;
    lineHeight=24;
    codeWidth=300;
  }
  void setPos(int x,int y){
    posX=x;
    posY=y;
  }
  void setWidth(int w){
    codeWidth=300;
  }
  void append(String s){
    lines[sz]=s;
    sz++;
  }
  void setHighLighter(int ln){
    if(ln<=sz)
      highlighter=ln-1;
  }
  void draw(){
    textAlign(LEFT);
    fill(#FFFFFF);
    stroke(#000000);
    rect(posX,posY,codeWidth,sz*lineHeight+10);
    fill(#FFFF99);
    stroke(#FFFFFF);
    rect(posX+5,posY+(highlighter*lineHeight+lineHeight/4),codeWidth-10,lineHeight);
    fill(#000000);
    for(int i=0;i<sz;i++){
      text(lines[i],posX+10,posY+((i+1)*lineHeight));
    }
  }
 }
