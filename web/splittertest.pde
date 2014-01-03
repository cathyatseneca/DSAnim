Splitter s;
float startTime;
int ln;
int count;
AnimationInstruction [] ai;
void setup(){
  size(800,500);
  s=new Splitter("left","right",color(255,0,0),color(0,255,0),15,30,100,100);
  ai=new AnimationInstruction[16];
  for(int i=0;i<16;i++){
    ai[i]=new AnimationInstruction(0,SET,i);
  }
  startTime=millis();
  count =0;
  s.process(ai[count]);
}
void draw(){
  float currTime=millis();
  if(currTime-startTime >= 1000){
    count++;
    if(count >= 16){
      count=0;
    }
    s.process(ai[count]);
    startTime=currTime;
  }
  background(30,60,90);
  ellipse(100,100,10,10);
  s.draw();
}
 
