
Animation anim;
AnimatedCode code;
AnimatedNode list;
Pointer ptr;
Pointer ptr2;
int numNodes;


boolean midStep(){
    boolean rc=true;
    if(anim.animationState_==PAUSED){
        rc=false;
    }
    return rc;
}

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
    AnimatedNode node=new AnimatedNode(val,150,150);
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
    AnimatedNode node=new AnimatedNode(val,150+numNodes*75,150);
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

void removeValue(){
    if(numNodes != 0){
        AnimatedNode first=list.pointers_[0];
        ptr.setPtr(null);
        anim.addStep();
        anim.addInstruction(1,SETVISIBILITY,VISIBLE);
        anim.addStep();
        anim.addNodeInstruction(1,CHANGENEXT,first);
        int firstID=first.id_;
        AnimatedNode curr=first.next_;
        if(first.next_ != null){
            anim.addStep();
            anim.addNodeInstruction(0,CHANGENEXT,first.next_,0);
            anim.addStep();
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
            anim.addInstruction(firstID,REMOVENODE);
            anim.addStep();
            anim.addNodeInstruction(0,CHANGENEXT,null,0);
            anim.addStep();            
            anim.addNodeInstruction(0,CHANGENEXT,null,1);
            anim.addStep();
            anim.addInstruction(1,SETVISIBILITY,HIDDEN);
        }
        anim.start();
        numNodes--;
    }
}

void removeBack(){
    if(numNodes != 0){
        AnimatedNode curr=list.pointers_[0];
        AnimatedNode prev=null;
        ptr.setPtr(null);
        ptr2.setPtr(null);
        anim.addStep();
        anim.addInstruction(1,SETVISIBILITY,VISIBLE);
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        anim.addStep();
        anim.addNodeInstruction(1,CHANGENEXT,curr);
        for(int i=0;i<numNodes-1;i++){
            prev=curr;
            anim.addStep();
            anim.addNodeInstruction(2,CHANGENEXT,curr);
            anim.addStep();
            anim.addNodeInstruction(1,CHANGENEXT,curr.next_)
            curr=curr.next_;
        }
        if(prev != null){
            int lastID=curr.id_;
            int prevID=prev.id_;
            anim.addStep();
            anim.addInstruction(lastID,REMOVENODE);
            anim.addStep();
            anim.addInstruction(1,SETVISIBILITY,HIDDEN);
            anim.addInstruction(2,SETVISIBILITY,HIDDEN);
            anim.addStep();
            anim.addNodeInstruction(0,CHANGENEXT,prev,1);
            anim.addStep();
            anim.addNodeInstruction(prevID,CHANGENEXT,null);
        }
        else{
            int lastID=curr.id_;
            anim.addStep();
            anim.addInstruction(lastID,REMOVENODE);

            anim.addStep();
            anim.addInstruction(1,SETVISIBILITY,HIDDEN);
            anim.addInstruction(2,SETVISIBILITY,HIDDEN);
            anim.addStep();
            anim.addNodeInstruction(0,CHANGENEXT,null,0);
            anim.addStep();
            anim.addNodeInstruction(0,CHANGENEXT,null,1);        
        }
        anim.start();
        numNodes--;
    }
}

void setup(){
    size(800,400);
    anim=new Animation(800, 400);
    anim.setColour(backgroundColour);    
    String [] labels=new String[3];
    labels[0]="first";
    labels[1]="last";
    list = new ListNode(labels,2,50,100);
    ptr = new Pointer ("curr",200,50);
    ptr.setVisibility(HIDDEN);
    ptr2 = new Pointer ("prev",100,50);
    ptr2.setVisibility(HIDDEN);
    anim.addObject(list);
    anim.addObject(ptr);
    anim.addObject(ptr2);
}
void draw(){
    anim.draw();
}

/*void mousePressed(){
  anim.setState(RUNNING);
}*/

