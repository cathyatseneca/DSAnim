class BubbleSort{
  ArrayAnim arr;
  int currJ;
  boolean sorted;
  int sortLength;
  BubbleSort(int sz){
    arr=new ArrayAnim(sz);
    arr.splitterOn("unsorted","sorted",#FF0000,#00FF00,sz);
    arr.barsOn();
    arr.fillRandom();
    arr.addIndicator(0);
    arr.addIndicator(1);
    arr.setPos(60,100);
    currJ=0;
    sorted=false;
    sortLength=sz- 1;
  }
  void draw(){
    if(!sorted){
      if(arr.state==arr.STABLE){
        if(arr.atIdx(currJ)>arr.atIdx(currJ+1)){
          arr.setLetterColour(currJ,#ff0000);
          arr.setLetterColour(currJ+1,#ff0000);
          arr.swap(currJ,currJ+1);
        }
        if(arr.state==arr.STABLE){
          arr.setLetterColour(currJ+1,#000000);
          arr.setLetterColour(currJ,#000000);
          currJ++;
        
          arr.changeIndicator(0,currJ);
          arr.changeIndicator(1,currJ+1);
          if(currJ >= sortLength){
            currJ=0;
            arr.changeIndicator(0,currJ);
            arr.changeIndicator(1,currJ+1);
            sortLength--;
            if(sortLength==0)
              sorted=true;
          }
          arr.setSplitterPosition(sortLength+1);
        }
      }
    }
    else{
      arr.setSplitterPosition(0);
    }
    arr.draw();
  }
}

BubbleSort bubble;
int count;
ArrayAnim arr;
//PFont fontA = loadFont("Courier");
void setup(){
 size(900,500);
 background(33,66,99);
 bubble=new BubbleSort(15);
 frameRate(1);
}
void draw(){
   bubble.draw();   
}
