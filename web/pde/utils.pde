//draws a squaer with the number c inside it.  Assume that c is 
//2 digits max.
//offsetX and offsetY are positional offset from top left corner of draw
//area.  X is the number of squares away from offsetX position
//co is colour of text
//sz is size of the square
void drawSqWithNum(int x,int c,color co,int sz,int offsetX,int offsetY){
  stroke(0);
  fill(255);
  rect(offsetX+x*(sz),offsetY,sz,sz);
  fill(co);
  if(c>0){
    textAlign(CENTER);
    text(c,offsetX+((x+0.5)*sz),offsetY+(sz*0.5)+5);
  }
}

//draws a squaer with 
//offsetX and offsetY are positional offset from top left corner of draw
//area.  X is the number of squares away from offsetX position
void drawSquare(int x,int sz, int offsetX,int offsetY){
  stroke(0);
  fill(255);
  rect(offsetX+x*(sz),offsetY,sz,sz);
}

//draws a  triangle 
//posX and posY are positional offset from top left corner of draw
//area.  X is the number of squares away from posX position
void drawTriangle(int x, int sz,int posX,int posY){
  stroke(255);
  fill(255);
  triangle(posX+((x+0.5)*sz),posY+sz, posX+((x+0.5)*sz)-10,posY+sz+10,posX+((x+0.5)*sz)+10, posY+sz+10);
}


