AnimatedCode bubblecode;
int count;
int ln;
void setup(){
  bubblecode=new AnimatedCode("bubble.txt",100,100);
  size(500,500);
  bubblecode.append("line 1");
  bubblecode.append("line 2");
  bubblecode.append("line 3");
  bubblecode.append("line 4");
  bubblecode.append("line 5");
  bubblecode.append("line 6");
  bubblecode.append("line 7");
  frameRate(1);
  count=0;
  ln=1;
  bubblecode.setHighLighter(ln);
}
void draw(){
  count++;
  bubblecode.draw();
    ln++;
    bubblecode.setHighLighter(ln);
}
 
