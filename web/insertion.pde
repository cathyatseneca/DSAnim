class InsertionSort{
  ArrayAnim array_;
  int currJ_;
  boolean sorted_;
  int sortLength_;
  boolean freshLoop_;  //true each time we increase the size of "sorted" array
  int cap_;
  InsertionSort(int sz){
    array_=new ArrayAnim(sz);
    array_.splitterOn("sorted","unsorted",#00FF00,#FF0000,1);
    array_.barsOn();
    array_.fillRandom();
    array_.addIndicator(0);
    array_.tempOn();
    currJ_=1;
    cap_=sz;
    sorted_=false;
    sortLength_=1;
    freshLoop_=true;
  }
  void draw(){
    if(!sorted_){
      if(array_.state()==array_.STABLE){
        if(freshLoop_){
          array_.moveToTemp(currJ_);
          freshLoop_=false;
          array_.setSplitterPosition(sortLength_+1);
        }
        else{
          if(currJ_==0){
            array_.moveFromTemp(0);
            sortLength_++;
            currJ_=sortLength_;
            freshLoop_=true;
            array_.changeIndicator(0,currJ_-1);
          }
          else{
            if(array_.atIdx(currJ_-1) > array_.temp_){
              if(currJ_!=0)
                array_.changeIndicator(0,currJ_-1);
              array_.move(currJ_-1,currJ_);
              currJ_--;

            }
            else{
              array_.moveFromTemp(currJ_);
              sortLength_++;
              currJ_=sortLength_;
              freshLoop_=true;
              array_.changeIndicator(0,currJ_-1);
            }
          }
          if(sortLength_==cap_){
            sorted_=true;
          }
        }
      }
    }     
    array_.draw();
  }
}

InsertionSort insertion;
//PFont fontA = loadFont("Courier");
void setup(){
 size(800,500);
 background(46,129,215);
 insertion=new InsertionSort(15);
 frameRate(1);
}
void draw(){
  background(46,129,215);
  insertion.draw();  
}


