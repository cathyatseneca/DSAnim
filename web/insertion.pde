class InsertionSort{
  ArrayAnim array_;
  int currJ_;
  boolean sorted_;
  int sortLength_;
  boolean freshLoop_;  //true each time we increase the size of "sorted" array
  int cap_;
  Code src_;
  InsertionSort(int sz){
    array_=new ArrayAnim(sz);
    array_.splitterOn("sorted","unsorted",#00FF00,#FF0000,1);
    array_.barsOn();
    array_.fillRandom();
    array_.addIndicator(0);
    array_.setPos(60,100);
    array_.tempOn();
    currJ_=1;
    cap_=sz;
    sorted_=false;
    sortLength_=1;
    freshLoop_=true;
    src_=new Code(20);
    setCode();
  }
  void draw(){
    if(!sorted_){
      if(array_.state()==array_.STABLE){
        if(freshLoop_){
          array_.moveToTemp(currJ_);
          freshLoop_=false;
          array_.setSplitterPosition(sortLength_+1);
          src_.setHighLighter(5);
        }
        else{
          if(currJ_==0){
            array_.moveFromTemp(0);
            sortLength_++;
            currJ_=sortLength_;
            freshLoop_=true;
            array_.changeIndicator(0,currJ_-1);
            src_.setHighLighter(9);
          }
          else{
            if(array_.atIdx(currJ_-1) > array_.temp_){
              if(currJ_!=0){
                array_.changeIndicator(0,currJ_-1);
              }
              array_.move(currJ_-1,currJ_);
              currJ_--;
              src_.setHighLighter(7);
            }
            else{
              array_.moveFromTemp(currJ_);
              sortLength_++;
              currJ_=sortLength_;
              freshLoop_=true;
              array_.changeIndicator(0,currJ_-1);
              src_.setHighLighter(9);
            }
          }
          if(sortLength_==cap_){
            sorted_=true;
            src_.setHighLighter(11);
          }
        }
      }
    }     
    array_.draw();
    src_.draw();
  }
  void setCode(){
    src_.append("void InsertionSort(int arr[],int size){");
    src_.append("  int curr");
    src_.append("  int i, j;");
    src_.append("  for(i=1;i<size;i++){");
    src_.append("    curr=arr[i];");
    src_.append("    for(j=i;j>0 && arr[j-1] > curr;j--){");
    src_.append("      arr[j]=arr[j-1];");
    src_.append("    }");
    src_.append("    arr[j]=curr;");
    src_.append("  }");
    src_.append("}");
    src_.setHighLighter(4);
    src_.setPos(550,100);
  }
}

InsertionSort insertion;
//PFont fontA = loadFont("Courier");
void setup(){
 size(900,500);
 background(46,129,215);
 insertion=new InsertionSort(15);
 frameRate(1);
}
void draw(){
  background(46,129,215);
  insertion.draw();  
}


