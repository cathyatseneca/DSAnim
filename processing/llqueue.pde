
Animation anim;
AnimatedNode list;
Pointer ptr;
Pointer ptr2;
AnimatedText status;
int numNodes;
int oldMemberIdx=-1;
int currMemberIdx;

boolean midStep(){
    boolean rc=true;
    if(anim.animationState_==PAUSED){
        rc=false;
    }
    return rc;
}
void hideOldInfo(){
    if(status.isVisible()==true){
        anim.addStep();
        anim.addInstruction(3,SETVISIBILITY,HIDDEN);
    }
}
void insertValue(int val){
    int id;
    hideOldInfo();
    anim.addStep();
    anim.addNodeInstruction(1,SET,null);
    anim.addInstruction(1,SETVISIBILITY,VISIBLE);

    AnimatedNode node=new AnimatedNode(val,150+numNodes*75,100);
    node.setVisibility(HIDDEN);
    anim.addObject(node);
    id=node.id_;
    anim.addStep();
    anim.addNodeInstruction(1,CHANGENEXT,node);
    anim.addStep();
    anim.addInstruction(id,SETVISIBILITY,VISIBLE);

    if(numNodes==0){

        anim.addStep();
        anim.addNodeInstruction(0,CHANGENEXT,node,0);
        anim.addStep();
        anim.addNodeInstruction(0,CHANGENEXT,node,1);
    }
    else{
        int lastID=list.pointers_[1].id_;
        anim.addStep();
        anim.addNodeInstruction(lastID,CHANGENEXT,node);
        anim.addStep();
        anim.addNodeInstruction(0,CHANGENEXT,node,1);
    }
    anim.addStep();
    anim.addInstruction(1,SETVISIBILITY,0);
    anim.start();
    numNodes++;

}
void rm(){
    int id;
    hideOldInfo();

    if(numNodes != 0){
        AnimatedNode first=list.pointers_[0];
        ptr.setPtr(null);
        anim.addStep();
        anim.addInstruction(1,SETVISIBILITY,VISIBLE);
        anim.addStep();
        anim.addNodeInstruction(1,CHANGENEXT,first);
        int firstID=first.id_;
        AnimatedNode curr=first.next_;
        if(numNodes!= 1){
            anim.addStep();
            anim.addNodeInstruction(0,CHANGENEXT,first.next_,0);
            anim.addInstruction(firstID,REMOVENODE);
            anim.addStep();
            anim.addInstruction(1,SETVISIBILITY,HIDDEN);
            anim.addStep();
            while(curr!=null){
                int id=curr.id_;
                anim.addInstruction(id,MOVELOCATION,curr.x_-75,curr.y_);
                curr=curr.next_;
            }           
        }
        else{
            anim.addStep();
            anim.addNodeInstruction(0,CHANGENEXT,null,0);
            anim.addStep();            
            anim.addNodeInstruction(0,CHANGENEXT,null,1);

            anim.addStep();
            anim.addInstruction(firstID,REMOVENODE);

            anim.addStep();
            anim.addInstruction(1,SETVISIBILITY,HIDDEN);
        }
        anim.start();
        numNodes--;
    }
}

void isEmpty(){
    hideOldInfo();

    anim.addStep();
    if(numNodes == 0){
        anim.addStringInstruction(3,SET,"isEmpty(): TRUE");
    }
    else{
        anim.addStringInstruction(3,SET,"isEmpty(): FALSE");
    }
    anim.addInstruction(3,SETVISIBILITY,VISIBLE);
    anim.start();
}
void isFull(){

    hideOldInfo();
    anim.addStep();
    anim.addInstruction(3,SETVISIBILITY,VISIBLE);
    anim.addStringInstruction(3,SET,"isFull(): FALSE");
    anim.start();
}
void getValue(){

    hideOldInfo();
    anim.addStep();
    if(numNodes == 0){
        anim.addStringInstruction(3,SET,"Queue is Empty");
        anim.addStep();
        anim.addInstruction(3,SETVISIBILITY,VISIBLE);
    }
    else{
        int frontValue=list.pointers_[0].data_;
        anim.addStringInstruction(3,SET,"Value at front: " + frontValue);
        anim.addStep();
        anim.addInstruction(3,SETVISIBILITY,VISIBLE);
    }
    anim.start();
}
void setup(){
    size(800,450);
    anim=new Animation(800, 450);
    anim.setColour(backgroundColour);    
    String [] labels=new String[3];
    labels[0]="first";
    labels[1]="last";
    list = new ListNode(labels,2,50,50);
    ptr = new Pointer ("curr",250,31);
    ptr.setVisibility(HIDDEN);
    ptr2 = new Pointer ("prev",150,31);
    ptr2.setVisibility(HIDDEN);
    status = new AnimatedText("",200,250,36,whiteColour);
    status.hide();

    anim.addObject(list);
    anim.addObject(ptr);
    anim.addObject(ptr2);
    anim.addObject(status);
}
void draw(){
    anim.draw();
}

/*void mousePressed(){
  anim.setState(RUNNING);
}*/

