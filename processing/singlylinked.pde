
Animation anim;
AnimatedCode nodeCode;
AnimatedCode listCode;
AnimatedCode [] memberFunctions;
AnimatedNode list;
Pointer ptr;
Pointer ptr2;
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
void setCode(){
    int i;
    String [] s={
    "class Node{",
    "    friend class SLList;",
    "    int data_;",
    "    Node* next_;    ",
    "    Node(int data,Node* n=NULL){",
    "        data_=data;",
    "        next_=n;",
    "    }",
    "};"
    };
    String [] s2={
    "class SLList{",
    "    Node* first_;",
    "    Node* last_;",
    "public:",
    "    SLList(){",
    "        first_=last_=NULL;",
    "    }",
    "    ...",
    "};"
    };
    String[] s3={
    "void SLList::insertFront(int data){",
    "    Node* nn=new Node(data,first_);",
    "    if(first_==NULL){",
    "        last_=nn;",
    "    }",
    "    first_=nn;",
    "}",
    "void SLList::insertBack(int data){",
    "    Node* nn=new Node(data);",
    "    if(first_==NULL){",
    "        first_=nn;",
    "        last_=nn;",
    "    }",
    "    else{",
    "        last_->next_=nn;",
    "        last_=nn;",
    "    }",
    "}",
    "void SLList::removeFront(){",
    "    if(first_){",
    "        Node* curr=first_;",
    "        if(first_ != last_){",
    "            first_=first_->next_;",
    "        }",
    "        else{",
    "            first_=NULL;",
    "            last_=NULL;",
    "        }",
    "        delete curr;",
    "    }",
    "}",
    "void SLList::removeBack(){",
    "    if(first_){",
    "        if(first_ != last_){",
    "            Node* prev=first;",
    "            while(prev->next_!=last_){",
    "                prev=prev->next_;",
    "            }",
    "            prev->next_=NULL;",
    "            delete last_;",
    "            last_=prev;",
    "        }",
    "        else{",
    "            delete last_;",
    "            last_=first_=NULL;",
    "        }",
    "    }",
    "}"
    };
    for(i=0;i<9;i++){
      nodeCode.append(s[i]);
    }
    for(i=0;i<9;i++){
      listCode.append(s2[i]);
    }
    int [] numLines={7,11,13,17};
    int k=0;
    for(i=0;i<4;i++){
        memberFunctions[i]=new AnimatedCode(500,200);
        for(int j=0;j<numLines[i];j++){
            memberFunctions[i].append(s3[k]);
            memberFunctions[i].hide();
            k++;
        }
    }
}
void hideOldInfo(){
    if(oldMemberIdx != -1 && oldMemberIdx != currMemberIdx){
        anim.addStep();
        anim.addInstruction(memberFunctions[oldMemberIdx].id_,SETVISIBILITY,HIDDEN);
    }
    oldMemberIdx=currMemberIdx;
}
void insertFront(int val){
    int id;
    currMemberIdx=0;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(5,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(5,SET,2);
    anim.addStep();
    anim.addNodeInstruction(1,SET,null);
    anim.addInstruction(1,SETVISIBILITY,VISIBLE);
    if(list.pointers_[0] != null){
        AnimatedNode curr=list.pointers_[0];
        anim.addStep();
        while(curr!=null){
            id=curr.id_;
            anim.addInstruction(id,MOVELOCATION,curr.x_+75,curr.y_);
            curr=curr.next_;
        }
    }
    AnimatedNode node=new AnimatedNode(val,150,100);
    node.setVisibility(HIDDEN);
    anim.addObject(node);
    id=node.id_;
    anim.addStep();
    anim.addNodeInstruction(1,CHANGENEXT,node);
    anim.addStep();
    anim.addInstruction(3,SET,6);
    anim.addInstruction(id,SETVISIBILITY,VISIBLE);
    if(numNodes!=0){
        anim.addStep();
        anim.addInstruction(3,SET,7);
        anim.addNodeInstruction(id,CHANGENEXT,list.pointers_[0]);
        anim.addStep();
        anim.addInstruction(3,SET,0);
        anim.addInstruction(5,SET,3);        
        anim.addStep();
        anim.addInstruction(5,SET,6);
        anim.addNodeInstruction(0,CHANGENEXT,node,0);
    }
    else{
        anim.addStep();
        anim.addInstruction(3,SET,7);
        anim.addStep();
        anim.addInstruction(3,SET,0);
        anim.addInstruction(5,SET,3);
        anim.addStep();
        anim.addInstruction(5,SET,4);
        anim.addNodeInstruction(0,CHANGENEXT,node,1);
        anim.addStep();
        anim.addInstruction(5,SET,6);
        anim.addNodeInstruction(0,CHANGENEXT,node,0);
    }
    anim.addStep();
    anim.addInstruction(5,SET,0);
    anim.addInstruction(1,SETVISIBILITY,0);
    numNodes++;
    anim.start();
}
void insertBack(int val){
    int id;
    currMemberIdx=1;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(6,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(6,SET,2);

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
    anim.addInstruction(3,SET,6);
    anim.addInstruction(id,SETVISIBILITY,VISIBLE);

    if(numNodes==0){
        anim.addStep();
        anim.addInstruction(3,SET,7);
        anim.addStep();
        anim.addInstruction(3,SET,0);
        anim.addInstruction(6,SET,3);
        anim.addStep();
        anim.addInstruction(6,SET,4);
        anim.addStep();
        anim.addNodeInstruction(0,CHANGENEXT,node,0);
        anim.addStep();
        anim.addInstruction(6,SET,5);
        anim.addStep();
        anim.addNodeInstruction(0,CHANGENEXT,node,1);
    }
    else{
        int lastID=list.pointers_[1].id_;
        anim.addStep();
        anim.addInstruction(3,SET,7);
        anim.addStep();
        anim.addInstruction(3,SET,0);
        anim.addInstruction(6,SET,3);
        anim.addStep();
        anim.addInstruction(6,SET,8);
        anim.addStep();
        anim.addNodeInstruction(lastID,CHANGENEXT,node);
        anim.addStep();
        anim.addInstruction(6,SET,9);
        anim.addStep();
        anim.addNodeInstruction(0,CHANGENEXT,node,1);
    }
    anim.addStep();
    anim.addInstruction(6,SET,0);
    anim.addInstruction(1,SETVISIBILITY,0);
    anim.start();
    numNodes++;

}

void removeFront(){
    int id;
    currMemberIdx=2;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(7,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(7,SET,2);

    if(numNodes != 0){
        AnimatedNode first=list.pointers_[0];
        ptr.setPtr(null);
        anim.addStep();
        anim.addInstruction(1,SETVISIBILITY,VISIBLE);
        anim.addStep();
        anim.addInstruction(7,SET,3);
        anim.addStep();
        anim.addNodeInstruction(1,CHANGENEXT,first);
        int firstID=first.id_;
        AnimatedNode curr=first.next_;
        anim.addStep();
        anim.addInstruction(7,SET,4);
        if(numNodes!= 1){
            anim.addStep();
            anim.addInstruction(7,SET,5);
            anim.addNodeInstruction(0,CHANGENEXT,first.next_,0);
            anim.addStep();
            anim.addInstruction(7,SET,11);
            anim.addInstruction(firstID,REMOVENODE);
            anim.addStep();
            anim.addInstruction(7,SET,0);
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
            anim.addInstruction(7,SET,8);
            anim.addNodeInstruction(0,CHANGENEXT,null,0);
            anim.addStep();            
            anim.addInstruction(7,SET,9);
            anim.addNodeInstruction(0,CHANGENEXT,null,1);

            anim.addStep();
            anim.addInstruction(7,SET,11);
            anim.addInstruction(firstID,REMOVENODE);

            anim.addStep();
            anim.addInstruction(7,SET,0);
            anim.addInstruction(1,SETVISIBILITY,HIDDEN);
        }
        anim.start();
        numNodes--;
    }
}

void removeBack(){
    currMemberIdx=3;
    hideOldInfo();
    anim.addStep();
    anim.addInstruction(8,SETVISIBILITY,VISIBLE);
    anim.addStep();
    anim.addInstruction(8,SET,2);
    if(numNodes != 0){
        anim.addStep();
        anim.addInstruction(8,SET,3);
        AnimatedNode prev=list.pointers_[0];
        int lastID=list.pointers_[1].id_;
        ptr2.setPtr(null);
        anim.addStep();
        anim.addInstruction(2,SETVISIBILITY,VISIBLE);
        if(numNodes != 1){
            anim.addStep();
            anim.addInstruction(8,SET,4);
            anim.addStep();
            anim.addNodeInstruction(2,CHANGENEXT,prev);

            for(int i=0;i<numNodes-2;i++){
                anim.addStep();
                anim.addInstruction(8,SET,5);
                prev=prev.next_;
                anim.addStep();
                anim.addNodeInstruction(2,CHANGENEXT,prev);
                anim.addInstruction(8,SET,6);
            }

            int prevID=prev.id_;

            anim.addStep();
            anim.addInstruction(8,SET,8);
            anim.addNodeInstruction(prevID,CHANGENEXT,null);

            anim.addStep();
            anim.addInstruction(8,SET,9);
            anim.addInstruction(lastID,REMOVENODE);
            anim.addStep();
            anim.addInstruction(8,SET,10);
            anim.addNodeInstruction(0,CHANGENEXT,prev,1);
            anim.addStep();
            anim.addInstruction(8,SET,0);
            anim.addInstruction(2,SETVISIBILITY,HIDDEN);
        }
        else{
            anim.addStep();
            anim.addInstruction(8,SET,13);
            anim.addInstruction(lastID,REMOVENODE);
            anim.addStep();
            anim.addInstruction(8,SET,14);
            anim.addNodeInstruction(0,CHANGENEXT,null,0);
            anim.addStep();
            anim.addNodeInstruction(0,CHANGENEXT,null,1);        
            anim.addStep();
            anim.addInstruction(8,SET,0);
            anim.addInstruction(2,SETVISIBILITY,HIDDEN);
        }
        anim.start();
        numNodes--;
    }
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
    nodeCode = new AnimatedCode(10,200);
    nodeCode.setWidth(250);
    nodeCode.setHighLighter(0);
    listCode = new AnimatedCode(280,200);
    listCode.setWidth(200);
    listCode.setHighLighter(0);
    memberFunctions=new AnimatedCode[4];
    setCode();
    anim.addObject(list);
    anim.addObject(ptr);
    anim.addObject(ptr2);
    anim.addObject(nodeCode);
    anim.addObject(listCode);
    for(int i=0;i<4;i++){
        anim.addObject(memberFunctions[i]);
    }
}
void draw(){
    anim.draw();
}

/*void mousePressed(){
  anim.setState(RUNNING);
}*/

