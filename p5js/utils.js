//draws a square with the number c inside it.  Assume that c is 
//2 digits max.
//offsetX and offsetY are positional offset from top left corner of draw
//area.
//co is colour of text
//sz is size of the square
function drawSqWithNum(c, co, bg, sz, offsetX, offsetY){
  stroke(0);
  fill(bg);
  rect(offsetX,offsetY,sz,sz);
  stroke(co);
  fill(co);
  textAlign(CENTER);
  text(c,offsetX+0.5*sz,offsetY+(sz*0.5)+5);
}

//draws a square 
//offsetX and offsetY are positional offset from top left corner of draw
//area.  X is the number of squares away from offsetX position
function drawSquare(sz, bg, offsetX, offsetY){
  stroke(0);
  fill(bg);
  rect(offsetX,offsetY,sz,sz);
}

//draws a  triangle that is placed under a square that has size of sz.
//posX and posY are positional offset from top left corner of draw
//area and the position of the square
function drawTriangle(co, posX, posY){
  stroke(co);
  fill(co);
  triangle(posX,posY,posX+10,posY+10,posX-10,posY+10);
}

//draws a  triangle that is placed under a square that has size of sz.
//posX and posY are positional offset from top left corner of draw
//area and the position of the square
function drawDownTriangle(co, posX, posY){
  stroke(co);
  fill(co);
  triangle(posX,posY,posX+10,posY-10,posX-10,posY-10);
}
