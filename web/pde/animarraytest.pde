int count;
ArrayAnim arr;
void setup(){
 size(800,500);
 background(33,66,99);
 arr=new ArrayAnim(15);
 arr.fillRandom();
 count=0;
}
void draw(){
  arr.draw();
  arr.tempOn();
  count++;
  if(count==5)
    arr.moveToTemp(5);
  if(count==20)
    arr.moveFromTemp(5);
  if(count==35)
    arr.swap(5,10);
  if(count==50)
    arr.move(5,3);

}
