class InsertionSort{
  ArrayAnim arr;
  int currJ;
  boolean sorted;
  int sortLength;
  boolean freshLoop;  //true each time we increase the size of "sorted" array
  int cap;
  InsertionSort(int sz){
    arr=new ArrayAnim(sz);
    arr.splitterOn("sorted","unsorted",#00FF00,#FF0000,1);
    arr.barsOn();
    arr.fillRandom();
    arr.addIndicator(0);
    arr.tempOn();
    currJ=1;
    cap=sz;
    sorted=false;
    sortLength=1;
    freshLoop=true;
  }
  void draw(){
    if(!sorted){
      if(arr.state==arr.STABLE){
        if(freshLoop){
          arr.moveToTemp(currJ);
          freshLoop=false;
          arr.setSplitterPosition(sortLength+1);
        }
        else{
          if(currJ==0){
            arr.moveFromTemp(0);
            sortLength++;
            currJ=sortLength;
            freshLoop=true;
            arr.changeIndicator(0,currJ-1);
          }
          else{
            if(arr.atIdx(currJ-1) > arr.temp){
              if(currJ!=0)
                arr.changeIndicator(0,currJ-1);
              arr.move(currJ-1,currJ);
              currJ--;

            }
            else{
              arr.moveFromTemp(currJ);
              sortLength++;
              currJ=sortLength;
              freshLoop=true;
              arr.changeIndicator(0,currJ-1);
            }
          }
          if(sortLength==cap){
            sorted=true;
          }
        }
      }
    }     
    arr.draw();
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

/*
ArrayAnim arr;
int count;
void setup(){
    size(800,500);
    background(46,129,215);
    arr=new ArrayAnim(15);
    arr.splitterOn("sorted","unsorted",#00FF00,#FF0000,0);
    arr.barsOn();
    arr.fillRandom();
    arr.addIndicator(1);
    arr.tempOn();

   count=0;
}
void draw(){
  arr.draw();
  count++;
  if(count==5)
    arr.moveToTemp(1);

}
*/
