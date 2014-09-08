
Animation anim;
AnimatedCode code;
AnimatedNode list;
int numNodes;

void insert(int val){
    int id;

    if(list.pointers_[0] != null){
        AnimatedNode curr=list.pointers_[0];
        anim.addStep();
        while(curr!=null){
            id=curr.id_;
            anim.addInstruction(id,MOVELOCATION,curr.x_+75,curr.y_);
            curr=curr.next_;
        }
        //move all nodes over
    }
    AnimatedNode node=new AnimatedNode(val,150,75);
    node.setVisibility(HIDDEN);
    anim.addObject(node);
    id=node.id_;
    anim.addStep();
    anim.addInstruction(id,SETVISIBILITY,VISIBLE);
    if(list.pointers_[0]!=null){
        anim.addStep();
        anim.addNodeInstruction(id,CHANGENEXT,list.pointers_[0]);
        anim.addStep();
        anim.addInstruction(0,BREAKNEXT,0);
    }
    anim.addStep();
    anim.addNodeInstruction(0,CHANGENEXT,node,0);
    if(list.pointers_[1]==null){
        anim.addStep();
        anim.addNodeInstruction(0,CHANGENEXT,node,1);
    }
    numNodes++;
    anim.start();
}
void insertBack(int val){
    int id;
    AnimatedNode node=new AnimatedNode(val,150+numNodes*75,75);
    anim.addObject(node);
    id=node.id_;
    if(list.pointers_[0]==null){
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
    anim.start();
    numNodes++;

}
void isEmpty(){
}
void isFull(){
}
void removeValue(){
}
void getValue(){
}
void setup(){
    size(800,400);
    anim=new Animation(800, 400);
    anim.setColour(backgroundColour);    
    String [] labels=new String[3];
    labels[0]="first";
    labels[1]="last";
    list = new ListNode(labels,2,50,50);
    anim.addObject(list);
}
void draw(){
    anim.draw();
}

/*void mousePressed(){
  anim.setState(RUNNING);
}*/

