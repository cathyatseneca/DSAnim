void setup(){
  size(800,500);
}
void draw(){
   for(int i=0;i<5;i++){
     drawSqWithNum(i+7,#FF0000,30,5+i*30,6);
     drawSquare(30,30*5+5+i*30,6);
     drawTriangle(30,5+i*30,6);
   }
   
   for(int i=0;i<5;i++){
     drawSqWithNum(i+1,#FF0000,50,5+i*50,56);
     drawSquare(50,50*5+5+i*50,56);
     drawTriangle(50,5+i*50, 56);
   }

   for(int i=0;i<5;i++){
     drawSqWithNum(i+1,#FF0000,60,5+i*60,136);
     drawSquare(60,60*5+5+i*60,136);
     drawTriangle(60,5+i*60, 136);
   }
}
