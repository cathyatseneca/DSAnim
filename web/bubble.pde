class BubbleSort{
  ArrayAnim array_;
  int currJ_;
  boolean sorted_;
  int sortLength_;
  Code src_;
  BubbleSort(int sz){
    array_=new ArrayAnim(sz);
    array_.splitterOn("unsorted","sorted",#FF0000,#00FF00,sz);
    array_.barsOn();
    array_.fillRandom();
    array_.addIndicator(0);
    array_.addIndicator(1);
    array_.setPos(60,100);
    currJ_=0;
    sorted_=false;
    sortLength_=sz- 1;
    src_=new Code(20);
    setCode();
  }
  void setCode(){
    src_.append("void BubbleSort(int array[],int sz){");
    src_.append("  int i;");
    src_.append("  int j;");
    src_.append("  for (i=0; i<sz; i++) {");
    src_.append("    for (j=0; j<size-1-i; j++){:");
    src_.append("      if (array[j+1] < array[j]) {");
    src_.append("        swap(array[j],array[j+1]);"); 
    src_.append("       }");
    src_.append("    }");
    src_.append("  }");
    src_.append("}");
    src_.setHighLighter(5);
    src_.setPos(550,100);
  }
  void draw(){
    if(!sorted_){
      if(array_.state()==array_.STABLE){
        if(array_.atIdx(currJ_)>array_.atIdx(currJ_+1)){
          src_.setHighLighter(7);
          array_.setLetterColour(currJ_,#ff0000);
          array_.setLetterColour(currJ_+1,#ff0000);
          array_.swap(currJ_,currJ_+1);
        }
        if(array_.state()==array_.STABLE){
          src_.setHighLighter(6);
          array_.setLetterColour(currJ_+1,#000000);
          array_.setLetterColour(currJ_,#000000);
          currJ_++;
        
          array_.changeIndicator(0,currJ_);
          array_.changeIndicator(1,currJ_+1);
          if(currJ_ >= sortLength_){
            src_.setHighLighter(4);
            currJ_=0;
            array_.changeIndicator(0,currJ_);
            array_.changeIndicator(1,currJ_+1);
            sortLength_--;
            if(sortLength_==0){
              sorted_=true;
              src_.setHighLighter(11);
            }
          }
          array_.setSplitterPosition(sortLength_+1);
        }
      }
    }
    else{
      array_.setSplitterPosition(0);
    }
    array_.draw();
    src_.draw();
  }
}

BubbleSort bubble;
int count;
ArrayAnim arr;
//PFont fontA = loadFont("Courier");
void setup(){
 size(900,500);
 background(46,129,215);
 bubble=new BubbleSort(15);
 frameRate(1);
}
void draw(){
   background(46,129,215);
   bubble.draw();   
}
