
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

  int [] data_;               //array, a negative value will be used to indicate "empty" spots
  int temp_;                  //some animations require the use temporary variables outside array, not drawn unless
                             //set to on
  int newTempVal_;            //used to prevent animation flash when moving value to the temp box
                             
  color [] letterColours_;    //colour of the values in the array.  Initialized to black
  
  int cap_;       //capacity of array (how much it can hold)
  int sz_;        //size of array (how much array currently holds)
  int state_;     //state of animation
  int to_;        //index of where value is going to (or left value for swap)
  int from_;      //index of where value is coming from (or right value for swap)
  int sqsz_;
  int []arcArray_;  
  int posX_;      //x position of arrayindex 0
  int posY_;      //y position of arrayindex 0  NOTE: this value needs to be at least
                 //sqsz more than 0 if there are splitters
  PFont arrayFont;

  int currFrame_;
  int leftValue_;
  int rightValue_;
  String splitterLeftLabel_;
  String splitterRightLabel_;
  color splitterLeftColour_;
  color splitterRightColour_;
  int splitterPosition_;
  
  int indicators_[];           //array of indicator locations (index where indicator points)
  int numIndicators_;
  
  boolean hasBars_;            //if true, bars will be drawn under the array showing its values
  boolean hasSplitter_;        //if true, a splitter will be drawn over the array that can be labeled
  boolean hasTemp_;            //if true, a temporary variable is shown
  
  int stableFPS_;
 
  void setconstants(){
    STABLE=1;
    SWAPPING=2;
    MOVING=3;
    MOVETOTEMP=4;
    MOVEFROMTEMP=5;
    posX_=120;
    posY_=120;
//    arrayFont=loadFont("Courier");
    textAlign(CENTER);
    sqsz_=30;
    int j=0;
    arcArray_=new int[9];
    for(int i=3;i>=0;i--){
      arcArray_[j]=(16-(i*i))*3;
      arcArray_[8-j]=arcArray_[j];
      j++;
    }
    arcArray_[4]=16*3;
    hasSplitter_=false;
    hasBars_=false;
    hasTemp_=false;
    
    for(int i=0;i<cap_;i++){
      letterColours_[i]=color(#000000);
    }
    stableFPS_=4;
    numIndicators_=0;
    frameRate(stableFPS_);
  }
  ArrayAnim(int c){
    sz_=0;
    cap_=c;
    data_=new int[c];
    letterColours_=new color[c];
    indicators_=new int[c];
    setconstants();
    state_=STABLE;
    super(posX_,posY_);
  }
  ArrayAnim(int [] arr,int c){
    sz_=c;
    cap_=c;
    data_=new int[c];
    for (int i=0;i< c;i++){
      data_[i]=arr[i];
    }
    indicators_=new int[c];
    setconstants();
    state_=STABLE;
    currFrame_=0;
    super(posX_,posY_);
  }
  int state(){return state_;}
  void setPosition(int x,int y){
    posX_=x;
    posY_=y;
    super.setPosition(x,y);
  }
  void setLetterColour(int pos,color c){
    letterColours_[pos]=c;
  }
  void barsOn(){
    hasBars_=true;
  }
  void tempOn(){
    hasTemp_=true;
  }  
  void splitterOn(String leftLabel, String rightLabel, color leftcolour, color rightcolour, int position){
    hasSplitter_=true;
    splitterLeftLabel_=leftLabel;
    splitterRightLabel_=rightLabel;
    splitterLeftColour_=leftcolour;
    splitterRightColour_=rightcolour;
    splitterPosition_=position;
  }
  void fillRandom(){
    for(int i=0;i<cap_;i++){
      data_[i]=int(random(1,99));
    }
    sz_=cap_;
  }
  void swap(int l,int r){
    state_=SWAPPING;
    to_=l;
    from_=r;
    leftValue_=data_[to_];
    rightValue_=data_[from_];
    data_[from_]=leftValue_;
    data_[to_]=rightValue_;
    currFrame_=0;
    frameRate(stableFPS_*8);
  }
  void move(int f,int t){
    state_=MOVING;
    from_=f;
    to_=t;
    data_[to_]=data_[from_];
    data_[from_]=-1;         //empty out the square
    currFrame_=0;
    frameRate(stableFPS_*8);
  }
  void moveToTemp(int fromidx){
    state_=MOVETOTEMP;
    from_=fromidx;
    newTempVal_=data_[fromidx];
    data_[fromidx]=-1;
    currFrame_=0;
    frameRate(stableFPS_*8);
  }
  void moveFromTemp(int toidx){
    state_=MOVEFROMTEMP;
    to_=toidx;
    newTempVal_=temp_;
    temp_=-1;
    currFrame_=0;
    frameRate(stableFPS_*8);
  }

  int atIdx(int idx){
    return data_[idx];
  }
  int atTemp(){
    return temp_;
  }
  void addIndicator(int loc){
    indicators_[numIndicators_]=loc;
    numIndicators_++;
  }
  void changeIndicator(int pos,int loc){
    if(pos < numIndicators_)
      indicators_[pos]=loc;
  }
  void setSplitterPosition(int idx){
    splitterPosition_=idx;
  }
  void draw(){
    switch(state_){
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
    if(hasBars_==true){
      drawBars();
    }
    if(hasSplitter_==true){
     drawSplitter();
    }
    if(numIndicators_>0){
      drawIndicators();
    }
  }
  void drawMoveToTemp(){
    if(currFrame_ <9){
       drawTemp();
       for(int i=0;i<sz_;i++){
        if(i==from_){
          drawSquare(sqsz_,posX_+i*sqsz_,posY_);
        }
        else{
          drawSqWithNum(data_[i],letterColours_[i],sqsz_,posX_+i*sqsz_,posY_);
        }
      }
      int diff=from_*sqsz_;
      int inc=diff/8;
      int incY=(sqsz_+10)/8;
      fill(letterColours_[from_]);
      text(newTempVal_,posX_+(from_+0.5)*sqsz_-(inc*currFrame_),posY_+(sqsz_*0.5)+9+incY*currFrame_);
      currFrame_++;
    }
    else{
      temp_=newTempVal_;
      drawStable();
      state_=STABLE;
      frameRate(stableFPS_);
    }    
  }

  void drawMoveFromTemp(){
    
    if(currFrame_ <9){
       drawTemp();
       drawStable();
      int diff=to_*sqsz_;
      int inc=diff/8;
      int incY=(sqsz_+10)/8;
      fill(letterColours_[from_]);
      text(newTempVal_,posX_+(0.5)*sqsz_+(inc*currFrame_),posY_+sqsz_+(sqsz_*0.5)+20-(incY*currFrame_));
      currFrame_++;
    }
    else{
      data_[to_]=newTempVal_;
      drawStable();
      state_=STABLE;
      frameRate(stableFPS_);
    }    
  }
  
  void drawTemp(){
    if(temp_>0){
      drawSqWithNum(temp_,#000000,sqsz_,posX_,posY_+50);
    }
    else{
      drawSquare(sqsz_,posX_,posY_+50);
    }
  }
  void drawIndicators(){
    for(int i=0;i<numIndicators_;i++){
      drawTriangle(sqsz_,posX_+indicators_[i]*sqsz_,posY_);
    }
  }
  void drawStable(){
    for(int i=0;i<sz_;i++){
      if(data_[i] > 0){
        drawSqWithNum(data_[i],letterColours_[i],sqsz_,posX_+i*sqsz_,posY_);
      }
      else{
        drawSquare(sqsz_,posX_+i*sqsz_,posY_);
      }
    }
    if(hasTemp_==true){
       drawTemp();
     }
  } 
  void drawBars(){
    for(int i=0;i<sz_;i++){
      if(data_[i]>0){
        drawBar(i,data_[i],#FFFFFF,sqsz_,posX_,posY_);
      }
    }   
  }
  void drawSwapping(){  
    if(currFrame_ <9){
      if(hasTemp_==true){
        drawTemp();
       }
       for(int i=0;i<sz_;i++){
        if(i==to_ || i==from_){
          drawSquare(sqsz_,posX_+i*sqsz_,posY_);
        }
        else{
          drawSqWithNum(data_[i],letterColours_[i],sqsz_,posX_+i*sqsz_,posY_);
        }
      }
      int diff=(from_-to_)*sqsz_;
      int inc=diff/8;
      fill(letterColours_[from_]);
      text(data_[from_],posX_+(to_+0.5)*sqsz_+inc*currFrame_,posY_+(sqsz_*0.5)+9-arcArray_[currFrame_]);
      fill(letterColours_[to_]);
      text(data_[to_],posX_+(from_+0.5)*sqsz_-(inc*currFrame_),posY_+(sqsz_*0.5)+9+arcArray_[currFrame_]);
      currFrame_++;

    }
    else{
      drawStable();
      state_=STABLE;
      frameRate(stableFPS_);
    }
  }
  void drawMoving(){
    if(currFrame_ < 9){
      if(hasTemp_==true){
         drawTemp();
      }
      for(int i=0;i<sz_;i++){
        if(i==to_ || i==from_){
          drawSquare(sqsz_,posX_+i*sqsz_,posY_);
        }
        else{
          drawSqWithNum(data_[i],letterColours_[i],sqsz_,posX_+i*sqsz_,posY_);
        }    
      }
      int diff=(to_-from_)*sqsz_;
      int inc=diff/8;
      fill(letterColours_[from_]);
      text(data_[to_],posX_+(from_+0.5)*sqsz_+(inc*currFrame_),posY_+(sqsz_*0.5)+9-arcArray_[currFrame_]);
      currFrame_++;

    }
    else{
      drawStable();
      state_=STABLE;
      frameRate(stableFPS_);
    }
  }
  void drawSplitter(){
    stroke(255);
    fill(255);
    int topX= posX_+(splitterPosition_*sqsz_);
    int topY= posY_-40;
    int endpt= posX_+(sqsz_*sz_);
    strokeWeight(3);
    line(topX,topY, topX, topY+30);
    strokeWeight(1);
    if(splitterPosition_ !=0){
      pushStyle();
      textAlign(LEFT);
      text(splitterLeftLabel_,posX_,topY);    
      popStyle();
      fill(splitterLeftColour_);
      stroke(splitterLeftColour_);
      line(posX_,topY+15,topX-5,topY+15);
      triangle(posX_,topY+15,posX_+10,topY+10,posX_+10,topY+20);
    }
    if(splitterPosition_!=sz_){
      fill(#FFFFFF);
      stroke(#FFFFFF);
      text(splitterRightLabel_,endpt,topY);    
      fill(splitterRightColour_);
      stroke(splitterRightColour_);
      line(topX+5,topY+15,endpt,topY+15);
      triangle(endpt,topY+15,endpt-10,topY+10,endpt-10,topY+20);
    }
  }
  
}



