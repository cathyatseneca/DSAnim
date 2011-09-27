void setup(){
  size(800,500);
}
void draw(){
   for(int i=0;i<5;i++){
     drawSqWithNum(i, i+7,#FF0000,30,5,6);
     drawSquare(i,30,30*5+5,6);
     drawTriangle(i,30,5,6);
   }
   
   for(int i=0;i<5;i++){
     drawSqWithNum(i, i+1,#FF0000,50,5,56);
     drawSquare(i,50,50*5+5,56);
     drawTriangle(i,50,5, 56);
   }

   for(int i=0;i<5;i++){
     drawSqWithNum(i, i+1,#FF0000,60,5,136);
     drawSquare(i,60,60*5+5,136);
     drawTriangle(i,60,5, 136);
   }
}
