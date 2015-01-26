
Animation anim;
AnimatedArray arr;
Indicator iIndicator;
Indicator pivotIndicator;
Indicator greaterIndicator;
AnimatedCode code;

color pivotColor;
color iColor;
color greaterColor;

// Object ids
int arrayId, iIndicatorId, pivotIndicatorId, greaterIndicatorId, codeId;

void addObjects(){
    arrayId = anim.addObject(arr);
    iIndicatorId = anim.addObject(iIndicator);
    pivotIndicatorId = anim.addObject(pivotIndicator);
    greaterIndicatorId = anim.addObject(greaterIndicator);
    codeId = anim.addObject(code);
}

void swap(int arr[], int idxA, int idxB){
    if (idxA != idxB) {
        int tmp = arr[idxA];
        arr[idxA] = arr[idxB];
        arr[idxB] = tmp;
    }
}

void QuickAltSortA(int arr[], int left, int end){
    anim.addInstruction(codeId,SET,2);
    anim.addStep();

    // Clear colors
    if (left < end) {
        anim.addStep();
        anim.addInstruction(arrayId, SETBGCOLOURINRANGE, left, end - 1, 255, 255, 255);
    }

    int sz = end - left;
    anim.addInstruction(codeId,SET,3);
    anim.addStep();
    anim.addInstruction(codeId,SET,4);
    anim.addStep();
    if (sz >= 2) {  // Can't sort fewer than 2 elements
        anim.addInstruction(codeId,SET,5);
        anim.addStep();
        int pivotPt = int((left + end) / 2);    // Because an INT is treated like a js number... wtf

        anim.addInstruction(codeId,SET,6);
        anim.addStep();
        int pivotVal = arr[pivotPt];
        anim.addStep();
        anim.addInstruction(pivotIndicatorId,SETVISIBILITY,VISIBLE);
        anim.addInstruction(pivotIndicatorId,SET,pivotPt);

        // Place pivot at end of array
        anim.addStep();
        anim.addInstruction(codeId,SET,8);
        anim.addStep();
        if (pivotPt != end - 1) {
            anim.addInstruction(arrayId, SWAP, pivotPt, end - 1);
            swap(arr, pivotPt, end - 1);
        }
        anim.addInstruction(pivotIndicatorId, SET, end - 1);

        anim.addStep();
        anim.addInstruction(arrayId, SETBGCOLOUR, end - 1,
            red(pivotColor),
            green(pivotColor),
            blue(pivotColor));

        // Iterate over remaining elements
        // if not smaller than pivot, place at the end
        anim.addInstruction(codeId,SET,10);
        anim.addStep();
        int greater = 1, i = left;

        anim.addStep();
        anim.addInstruction(greaterIndicatorId,SET, end - greater);
        anim.addInstruction(iIndicatorId,SET, i);
        anim.addInstruction(iIndicatorId,SETVISIBILITY,VISIBLE);
        anim.addInstruction(greaterIndicatorId,SETVISIBILITY,VISIBLE);

        anim.addInstruction(codeId,SET,11);
        anim.addStep();
        while (i < end - greater) {
            anim.addInstruction(codeId,SET,12);
            anim.addStep();
            if (arr[i] < pivotVal) {
                i++; // As long as elem less than pivot, skip forward
                anim.addInstruction(codeId,SET,13);
                anim.addInstruction(iIndicatorId, SET, i);
                anim.addInstruction(arrayId, SETBGCOLOUR, i - 1,
                    red(iColor),
                    green(iColor),
                    blue(iColor));
                anim.addStep();
            }
            else {  // Otherwise, swap with last unsorted, if any
                anim.addInstruction(codeId,SET,14); // if ...
                anim.addStep();
                greater++;
                anim.addInstruction(codeId,SET,15);
                anim.addInstruction(greaterIndicatorId, SET, end - greater);
                anim.addStep();
                anim.addInstruction(codeId,SET,16);
                if (i != end - greater) {
                    anim.addStep();
                    anim.addInstruction(arrayId, SWAP, i, end - greater);
                    swap(arr, i, end - greater);
                }
                anim.addStep();
                anim.addInstruction(arrayId, SETBGCOLOUR, end - greater,
                    red(greaterColor),
                    green(greaterColor),
                    blue(greaterColor));
                anim.addStep();
            }

            anim.addInstruction(codeId,SET,11);
            anim.addStep();
        }

        anim.addInstruction(codeId,SET,20);
        anim.addStep();
        if (end - greater != end - 1) {
            anim.addInstruction(arrayId, SWAP, end - greater, end - 1);
            anim.addInstruction(pivotIndicatorId, SET, end - greater);
            swap(arr, end - greater, end - 1);
            anim.addStep();
        }

        anim.addInstruction(arrayId, SETBGCOLOUR, end - 1,
            red(greaterColor),
            green(greaterColor),
            blue(greaterColor));
        anim.addInstruction(arrayId, SETBGCOLOUR, end - greater, 189, 252, 201);
        anim.addInstruction(arrayId,SETFONTCOLOURINRANGE,end - greater,end - greater,200,200,200);
        anim.addStep();

        // Recurse
        anim.addInstruction(iIndicatorId,SETVISIBILITY,HIDDEN);
        anim.addInstruction(pivotIndicatorId,SETVISIBILITY,HIDDEN);
        anim.addInstruction(greaterIndicatorId,SETVISIBILITY,HIDDEN);
        anim.addStep();

        int leftGap = end - greater - 1;
        if (leftGap >= left) {
            anim.addInstruction(arrayId,ADDGAP,leftGap);
            anim.addInstruction(iIndicatorId,ADDGAP,leftGap);
            anim.addInstruction(pivotIndicatorId,ADDGAP,leftGap);
            anim.addInstruction(greaterIndicatorId,ADDGAP,leftGap);
            anim.addStep();
        }

        anim.addInstruction(codeId,SET,21);
        anim.addStep();
        QuickAltSortA(arr, left, end - greater);

        if (leftGap >= left) {
            anim.addInstruction(arrayId,REMOVEGAP,leftGap);
            anim.addInstruction(iIndicatorId,REMOVEGAP,leftGap);
            anim.addInstruction(pivotIndicatorId,REMOVEGAP,leftGap);
            anim.addInstruction(greaterIndicatorId,REMOVEGAP,leftGap);
            anim.addStep();
        }

        int rightGap = end - greater;
        if (rightGap < end - 1) {
            anim.addInstruction(arrayId,ADDGAP,rightGap);
            anim.addInstruction(iIndicatorId,ADDGAP,rightGap);
            anim.addInstruction(pivotIndicatorId,ADDGAP,rightGap);
            anim.addInstruction(greaterIndicatorId,ADDGAP,rightGap);
            anim.addStep();
        }

        anim.addInstruction(codeId,SET,22);
        anim.addStep();
        QuickAltSortA(arr, (end - greater) + 1, end);
        if (rightGap < end - 1) {
            anim.addInstruction(arrayId,REMOVEGAP,rightGap);
            anim.addInstruction(iIndicatorId,REMOVEGAP,rightGap);
            anim.addInstruction(pivotIndicatorId,REMOVEGAP,rightGap);
            anim.addInstruction(greaterIndicatorId,REMOVEGAP,rightGap);
            anim.addStep();
        }
    }
    anim.addInstruction(0,SETBGCOLOURINRANGE,left,end - 1,189,252,201);
    anim.addInstruction(arrayId,SETFONTCOLOURINRANGE,left,end - 1,200,200,200);
    anim.addInstruction(codeId,SET,24);
    anim.addStep();
}
void QuickAltSort(int arr[],int size){
    anim.addInstruction(arrayId,SETALLBGCOLOUR,255,255,255);
    anim.addInstruction(arrayId,SETALLFONTCOLOUR,0,0,0);
    anim.addInstruction(iIndicatorId,SETVISIBILITY,HIDDEN);
    anim.addInstruction(greaterIndicatorId,SETVISIBILITY,HIDDEN);
    anim.addInstruction(pivotIndicatorId,SETVISIBILITY,HIDDEN);
    anim.addStep();
    anim.addInstruction(codeId,SET,25);
    anim.addStep();
    anim.addInstruction(codeId,SET,26);
    anim.addStep();
    QuickAltSortA(arr,0,size);
    anim.addInstruction(codeId,SET,0);
    anim.addStep();
}
void setup(){
    size(900,500);
    anim=new Animation(900, 500);
    anim.setColour(color(46,129,215));
    int [] array=new int[15];
    for(int i=0;i<15;i++){
        array[i]=int(random(1,99));
    }

    arr=new AnimatedArray(array,15,15,230);
    arr.hasBars_=true;
    arr.setBarOffset(-130);

    pivotColor = color(252, 189, 201);
    iColor = color(189, 201, 252);
    greaterColor = color(252, 189, 64);

    iIndicator = new Indicator("i",iColor,30,30,260);
    greaterIndicator = new Indicator("greater", greaterColor, 30, 30, 260);
    pivotIndicator=new Indicator("pivot",pivotColor,30,30,230);
    pivotIndicator.pointDown();
    code=new AnimatedCode("quick_alt.txt", 530,50);
    code.setWidth(350);

    int tmp;

    addObjects();
    QuickAltSort(array,15);
    anim.start();
}
void draw(){
    anim.draw();
}


