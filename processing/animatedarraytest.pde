int count;
AnimatedArray arr;
AnimationInstruction ai;
void setup(){
 size(800,500);
 background(33,66,99);
 arr=new AnimatedArray(15, 100,100);
 arr.fillRandom();
 ai=new AnimationInstruction(0,SWAP,5,10);
 count=0;
}
void draw(){

 if(count == 120){
  arr.process(ai);
 }
 else{
   background(33,66,99);
   arr.draw();
 }
 count ++;
}