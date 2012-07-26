
void drawBar(int idx,int value,color co,int sz,int posX,int posY){
  stroke(co);
  fill(co);
  int ystart=posY+sz*2+10;
  int xstart=posX+idx*sz+sz/2-10;
  rect(xstart,ystart+(200-(value*2)),20,value*2);
}

class ArrayAnim{
  int STABLE;
  int SWAPPING;
  int MOVING;
  int MOVETOTEMP;
  int MOVEFROMTEMP;

  int [] data;               //array, a negative value will be used to indicate "empty" spots
  int temp;                  //some animations require the use temporary variables outside array, not drawn unless
                             //set to on
  int newTempVal;            //used to prevent animation flash when moving value to the temp box
                             
  color [] letterColours;    //colour of the values in the array.  Initialized to black
  
  int cap;       //capacity of array (how much it can hold)
  int sz;        //size of array (how much array currently holds)
  int state;     //state of animation
  int to;        //index of where value is going to (or left value for swap)
  int from;      //index of where value is coming from (or right value for swap
  int sqsz;
  int []arcarray;  
  int posX;      //x position of arrayindex 0
  int posY;      //y position of arrayindex 0  NOTE: this value needs to be at least
                 //sqsz more than 0 if there are splitters
  PFont arrayFont;

  int currFrame;
  int leftval;
  int rightval;
  String splitterLeftLabel;
  String splitterRightLabel;
  color splitterLeftColour;
  color splitterRightColour;
  int splitterPosition;
  
  int indicators[];           //array of indicator locations (index where indicator points)
  int numIndicators;
  
  boolean hasBars;            //if true, bars will be drawn under the array showing its values
  boolean hasSplitter;        //if true, a splitter will be drawn over the array that can be labeled
  boolean hasTemp;            //if true, a temporary variable is shown
  
  int stableFPS;
 
  void setconstants(){
    STABLE=1;
    SWAPPING=2;
    MOVING=3;
    MOVETOTEMP=4;
    MOVEFROMTEMP=5;
    posX=120;
    posY=120;
//    arrayFont=loadFont("Courier");
    textAlign(CENTER);
    sqsz=30;
    int j=0;
    arcarray=new int[9];
    for(int i=3;i>=0;i--){
      arcarray[j]=(16-(i*i))*3;
      arcarray[8-j]=arcarray[j];
      j++;
    }
    arcarray[4]=16*3;
    hasSplitter=false;
    hasBars=false;
    hasTemp=false;
    
    for(int i=0;i<cap;i++){
      letterColours[i]=color(#000000);
    }
    stableFPS=4;
    numIndicators=0;
    frameRate(stableFPS);
  }
  ArrayAnim(int c){
    sz=0;
    cap=c;
    data=new int[c];
    letterColours=new color[c];
    indicators=new int[c];
    setconstants();
    state=STABLE;
  }
  ArrayAnim(int [] arr,int c){
    sz=c;
    cap=c;
    data=new int[c];
    for (int i=0;i< c;i++){
      data[i]=arr[i];
    }
    indicators=new int[c];
    setconstants();
    state=STABLE;
    currFrame=0;
  }
  void setPos(int x,int y){
    posX=x;
    posY=y;
  }
  void setLetterColour(int pos,color c){
    letterColours[pos]=c;
  }
  void barsOn(){
    hasBars=true;
  }
  void tempOn(){
    hasTemp=true;
  }  
  void splitterOn(String leftLabel, String rightLabel, color leftcolour, color rightcolour, int position){
    hasSplitter=true;
    splitterLeftLabel=leftLabel;
    splitterRightLabel=rightLabel;
    splitterLeftColour=leftcolour;
    splitterRightColour=rightcolour;
    splitterPosition=position;
  }
  void fillRandom(){
    for(int i=0;i<cap;i++){
      data[i]=int(random(1,99));
    }
    sz=cap;
  }
  void swap(int l,int r){
    state=SWAPPING;
    to=l;
    from=r;
    leftval=data[to];
    rightval=data[from];
    data[from]=leftval;
    data[to]=rightval;
    currFrame=0;
    frameRate(stableFPS*8);
  }
  void move(int f,int t){
    state=MOVING;
    from=f;
    to=t;
    data[to]=data[from];
    data[from]=-1;         //empty out the square
    currFrame=0;
    frameRate(stableFPS*8);
  }
  void moveToTemp(int fromidx){
    state=MOVETOTEMP;
    from=fromidx;
    newTempVal=data[fromidx];
    data[fromidx]=-1;
    currFrame=0;
    frameRate(stableFPS*8);
  }
  void moveFromTemp(int toidx){
    state=MOVEFROMTEMP;
    to=toidx;
    newTempVal=temp;
    temp=-1;
    currFrame=0;
    frameRate(stableFPS*8);
  }

  int atIdx(int idx){
    return data[idx];
  }
  int atTemp(){
    return temp;
  }
  void addIndicator(int loc){
    indicators[numIndicators]=loc;
    numIndicators++;
  }
  void changeIndicator(int pos,int loc){
    if(pos < numIndicators)
      indicators[pos]=loc;
  }
  void setSplitterPosition(int idx){
    splitterPosition=idx;
  }
  void draw(){
    switch(state){
      case 1: 
         drawStable();
         break;
      case 2:
         drawSwapping();
         break;
      case 3:
         drawMoving();
         break;
      case 4:
         drawMoveToTemp();
         break;
      case 5:
         drawMoveFromTemp();
         break;
    }
    if(hasBars==true){
      drawBars();
    }
    if(hasSplitter==true){
     drawSplitter();
    }
    if(numIndicators>0){
      drawIndicators();
    }
  }
  void drawMoveToTemp(){
    if(currFrame <9){
       drawTemp();
       for(int i=0;i<sz;i++){
        if(i==from){
          drawSquare(sqsz,posX+i*sqsz,posY);
        }
        else{
          drawSqWithNum(data[i],letterColours[i],sqsz,posX+i*sqsz,posY);
        }
      }
      int diff=from*sqsz;
      int inc=diff/8;
      int incY=(sqsz+10)/8;
      fill(letterColours[from]);
      text(newTempVal,posX+(from+0.5)*sqsz-(inc*currFrame),posY+(sqsz*0.5)+9+incY*currFrame);
      currFrame++;
    }
    else{
      temp=newTempVal;
      drawStable();
      state=STABLE;
      frameRate(stableFPS);
    }    
  }

  void drawMoveFromTemp(){
    
    if(currFrame <9){
       drawTemp();
       drawStable();
      int diff=to*sqsz;
      int inc=diff/8;
      int incY=(sqsz+10)/8;
      fill(letterColours[from]);
      text(newTempVal,posX+(0.5)*sqsz+(inc*currFrame),posY+sqsz+(sqsz*0.5)+20-(incY*currFrame));
      currFrame++;
    }
    else{
      data[to]=newTempVal;
      drawStable();
      state=STABLE;
      frameRate(stableFPS);
    }    
  }
  
  void drawTemp(){
    if(temp>0){
      drawSqWithNum(temp,#000000,sqsz,posX,posY+50);
    }
    else{
      drawSquare(sqsz,posX,posY+50);
    }
  }
  void drawIndicators(){
    for(int i=0;i<numIndicators;i++){
      drawTriangle(sqsz,posX+indicators[i]*sqsz,posY);
    }
  }
  void drawStable(){
    for(int i=0;i<sz;i++){
      if(data[i] > 0){
        drawSqWithNum(data[i],letterColours[i],sqsz,posX+i*sqsz,posY);
      }
      else{
        drawSquare(sqsz,posX+i*sqsz,posY);
      }
    }
    if(hasTemp==true){
       drawTemp();
     }
  } 
  void drawBars(){
    for(int i=0;i<sz;i++){
      if(data[i]>0){
        drawBar(i,data[i],#FFFFFF,sqsz,posX,posY);
      }
    }   
  }
  void drawSwapping(){  
    if(currFrame <9){
      if(hasTemp==true){
        drawTemp();
       }
       for(int i=0;i<sz;i++){
        if(i==to || i==from){
          drawSquare(sqsz,posX+i*sqsz,posY);
        }
        else{
          drawSqWithNum(data[i],letterColours[i],sqsz,posX+i*sqsz,posY);
        }
      }
      int diff=(from-to)*sqsz;
      int inc=diff/8;
      fill(letterColours[from]);
      text(data[from],posX+(to+0.5)*sqsz+inc*currFrame,posY+(sqsz*0.5)+9-arcarray[currFrame]);
      fill(letterColours[to]);
      text(data[to],posX+(from+0.5)*sqsz-(inc*currFrame),posY+(sqsz*0.5)+9+arcarray[currFrame]);
      currFrame++;

    }
    else{
      drawStable();
      state=STABLE;
      frameRate(stableFPS);
    }
  }
  void drawMoving(){
    if(currFrame < 9){
      if(hasTemp==true){
         drawTemp();
      }
      for(int i=0;i<sz;i++){
        if(i==to || i==from){
          drawSquare(sqsz,posX+i*sqsz,posY);
        }
        else{
          drawSqWithNum(data[i],letterColours[i],sqsz,posX+i*sqsz,posY);
        }    
      }
      int diff=(to-from)*sqsz;
      int inc=diff/8;
      fill(letterColours[from]);
      text(data[to],posX+(from+0.5)*sqsz+(inc*currFrame),posY+(sqsz*0.5)+9-arcarray[currFrame]);
      currFrame++;

    }
    else{
      drawStable();
      state=STABLE;
      frameRate(stableFPS);
    }
  }
  void drawSplitter(){
    stroke(255);
    fill(255);
    int topX= posX+(splitterPosition*sqsz);
    int topY= posY-40;
    int endpt= posX+(sqsz*sz);
    strokeWeight(3);
    line(topX,topY, topX, topY+30);
    strokeWeight(1);
    if(splitterPosition !=0){
      text(splitterLeftLabel,posX-30,topY+17);    
      fill(splitterLeftColour);
      stroke(splitterLeftColour);
      line(posX,topY+15,topX-5,topY+15);
      triangle(posX,topY+15,posX+10,topY+10,posX+10,topY+20);
    }
    if(splitterPosition!=sz){
      fill(#FFFFFF);
      stroke(#FFFFFF);
      text(splitterRightLabel,endpt+30,topY+17);    
      fill(splitterRightColour);
      stroke(splitterRightColour);
      line(topX+5,topY+15,endpt,topY+15);
      triangle(endpt,topY+15,endpt-10,topY+10,endpt-10,topY+20);
    }
  }
}



