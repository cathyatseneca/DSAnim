class BubbleSort extends Animation{
	int [] array_;
	int capacity_;
	int arrayId_;
	int splitterId_;
	int codeId_;
	Bubble(int cap){
		super(800,600);
		array_=new int[cap];
		capacity_=cap;
		fillRandom();
		arrayId_=add(new AnimationObject(1,1));
		splitterId_=add(new AnimationObject(1,1));
		codeId_=add(new AnimationObject(1,1));
	}
	void fillRandom(){
    	for(int i=0;i<capacity_;i++){
      		array_[i]=int(random(1,99));
	    }
	}
	void doSort(){

		for(int i=0;i<capacity_;i++){
			for(int j=0;j<capacity_-1;j++){
				if(array_[j] > array[j+1]){
					int temp=array_[j];
					array_[j]=array_[j+1];
					array_[j+1]=temp;
				}
			}
		}
	}

   
}