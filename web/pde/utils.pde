//draws a square with the number c inside it.  Assume that c is 
//2 digits max.
//offsetX and offsetY are positional offset from top left corner of draw
//area.
//co is colour of text
//sz is size of the square
void drawSqWithNum(int c,color co,int sz,int offsetX,int offsetY){
  stroke(0);
  fill(255);
  rect(offsetX,offsetY,sz,sz);
  fill(co);
  if(c>0){
    textAlign(CENTER);
    text(c,offsetX+0.5*sz,offsetY+(sz*0.5)+5);
  }
}

//draws a square 
//offsetX and offsetY are positional offset from top left corner of draw
//area.  X is the number of squares away from offsetX position
void drawSquare(int sz, int offsetX,int offsetY){
  stroke(0);
  fill(255);
  rect(offsetX,offsetY,sz,sz);
}

//draws a  triangle that is placed under a square that has size of sz.
//posX and posY are positional offset from top left corner of draw
//area and the position of the square
void drawTriangle(int sz,int posX,int posY){
  stroke(255);
  fill(255);
  triangle(posX+0.5*sz,posY+sz, posX+(0.5*sz)-10,posY+sz+10,posX+(0.5*sz)+10, posY+sz+10);
}


