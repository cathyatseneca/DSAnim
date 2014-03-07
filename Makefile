WEB_DIR := web
PDE_DIR := $(WEB_DIR)
P5_DIR  := p5


p5-dir: clean
	@@mkdir $(P5_DIR)

p5-all: p5-dir $(PDE_DIR) merge-p5 quick-p5 bubble-p5 insertion-p5 arrayanim-p5 utils-p5 code-p5 animation-p5 animatedarray-p5 splitter-p5 selection-p5

bubble-p5: p5-dir $(PDE_DIR)/animation.pde $(PDE_DIR)/bubble.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde $(PDE_DIR)/animatedarray.pde $(PDE_DIR)/utils.pde $(PDE_DIR)/bubble.txt $(PDE_DIR)/splitter.pde $(PDE_DIR)/indicator.pde
	@@mkdir $(P5_DIR)/bubble
	cp $(PDE_DIR)/animation.pde $(P5_DIR)/bubble/animation.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/bubble/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/bubble/animationobject.pde
	cp $(PDE_DIR)/bubble.pde $(P5_DIR)/bubble/bubble.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/bubble/constants.pde
	cp $(PDE_DIR)/animatedcode.pde $(P5_DIR)/bubble/animatedcode.pde
	cp $(PDE_DIR)/animatedarray.pde $(P5_DIR)/bubble/animatedarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/bubble/utils.pde
	cp $(PDE_DIR)/bubble.txt $(P5_DIR)/bubble/bubble.txt
	cp $(PDE_DIR)/splitter.pde $(P5_DIR)/bubble/splitter.pde
	cp $(PDE_DIR)/indicator.pde $(P5_DIR)/bubble/indicator.pde

quick-p5: p5-dir $(PDE_DIR)/animation.pde $(PDE_DIR)/quick.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde $(PDE_DIR)/animatedarray.pde $(PDE_DIR)/utils.pde $(PDE_DIR)/splitter.pde $(PDE_DIR)/indicator.pde
	@@mkdir $(P5_DIR)/quick
	cp $(PDE_DIR)/animation.pde $(P5_DIR)/quick/animation.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/quick/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/quick/animationobject.pde
	cp $(PDE_DIR)/quick.pde $(P5_DIR)/quick/quick.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/quick/constants.pde
	cp $(PDE_DIR)/animatedcode.pde $(P5_DIR)/quick/animatedcode.pde
	cp $(PDE_DIR)/animatedarray.pde $(P5_DIR)/quick/animatedarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/quick/utils.pde
	cp $(PDE_DIR)/splitter.pde $(P5_DIR)/quick/splitter.pde
	cp $(PDE_DIR)/indicator.pde $(P5_DIR)/quick/indicator.pde

merge-p5: p5-dir $(PDE_DIR)/animation.pde $(PDE_DIR)/merge.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde $(PDE_DIR)/animatedarray.pde $(PDE_DIR)/utils.pde $(PDE_DIR)/indicator.pde
	@@mkdir $(P5_DIR)/merge
	cp $(PDE_DIR)/animation.pde $(P5_DIR)/merge/animation.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/merge/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/merge/animationobject.pde
	cp $(PDE_DIR)/merge.pde $(P5_DIR)/merge/merge.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/merge/constants.pde
	cp $(PDE_DIR)/animatedcode.pde $(P5_DIR)/merge/animatedcode.pde
	cp $(PDE_DIR)/animatedarray.pde $(P5_DIR)/merge/animatedarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/merge/utils.pde
	cp $(PDE_DIR)/indicator.pde $(P5_DIR)/merge/indicator.pde

insertion-p5: p5-dir $(PDE_DIR)/animation.pde $(PDE_DIR)/insertion.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde $(PDE_DIR)/animatedarray.pde $(PDE_DIR)/utils.pde $(PDE_DIR)/insertion.txt $(PDE_DIR)/splitter.pde $(PDE_DIR)/indicator.pde $(PDE_DIR)/animatedvariable.pde
	@@mkdir $(P5_DIR)/insertion
	cp $(PDE_DIR)/animation.pde $(P5_DIR)/insertion/animation.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/insertion/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/insertion/animationobject.pde
	cp $(PDE_DIR)/insertion.pde $(P5_DIR)/insertion/insertion.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/insertion/constants.pde
	cp $(PDE_DIR)/animatedcode.pde $(P5_DIR)/insertion/animatedcode.pde
	cp $(PDE_DIR)/animatedarray.pde $(P5_DIR)/insertion/animatedarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/insertion/utils.pde
	cp $(PDE_DIR)/insertion.txt $(P5_DIR)/insertion/insertion.txt
	cp $(PDE_DIR)/splitter.pde $(P5_DIR)/insertion/splitter.pde
	cp $(PDE_DIR)/indicator.pde $(P5_DIR)/insertion/indicator.pde
	cp $(PDE_DIR)/animatedvariable.pde $(P5_DIR)/insertion/animatedvariable.pde

selection-p5: p5-dir $(PDE_DIR)/animation.pde $(PDE_DIR)/selection.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde $(PDE_DIR)/animatedarray.pde $(PDE_DIR)/utils.pde $(PDE_DIR)/selection.txt $(PDE_DIR)/splitter.pde $(PDE_DIR)/indicator.pde $(PDE_DIR)/animatedvariable.pde
	@@mkdir $(P5_DIR)/selection
	cp $(PDE_DIR)/animation.pde $(P5_DIR)/selection/animation.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/selection/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/selection/animationobject.pde
	cp $(PDE_DIR)/selection.pde $(P5_DIR)/selection/selection.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/selection/constants.pde
	cp $(PDE_DIR)/animatedcode.pde $(P5_DIR)/selection/animatedcode.pde
	cp $(PDE_DIR)/animatedarray.pde $(P5_DIR)/selection/animatedarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/selection/utils.pde
	cp $(PDE_DIR)/selection.txt $(P5_DIR)/selection/selection.txt
	cp $(PDE_DIR)/splitter.pde $(P5_DIR)/selection/splitter.pde
	cp $(PDE_DIR)/indicator.pde $(P5_DIR)/selection/indicator.pde
	cp $(PDE_DIR)/animatedvariable.pde $(P5_DIR)/selection/animatedvariable.pde
	
arrayanim-p5: p5-dir $(PDE_DIR)/arrayanimtest.pde $(PDE_DIR)/arrayanim.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/arrayanimtest
	cp $(PDE_DIR)/arrayanimtest.pde $(P5_DIR)/arrayanimtest/arrayanimtest.pde
	cp $(PDE_DIR)/arrayanim.pde $(P5_DIR)/arrayanimtest/arrayanim.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/arrayanimtest/utils.pde

utils-p5: p5-dir $(PDE_DIR)/utiltest.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/utiltest
	cp $(PDE_DIR)/utiltest.pde $(P5_DIR)/utiltest/utiltest.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/utiltest/utils.pde

code-p5: p5-dir $(PDE_DIR)/animatedcode.pde $(PDE_DIR)/codetest.pde $(PDE_DIR)/utils.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde
	@@mkdir $(P5_DIR)/codetest
	cp $(PDE_DIR)/codetest.pde $(P5_DIR)/codetest/codetest.pde
	cp $(PDE_DIR)/animatedcode.pde $(P5_DIR)/codetest/animatedcode.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/codetest/constants.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/codetest/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/codetest/animationobject.pde

animation-p5: p5-dir $(PDE_DIR)/animation.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde $(PDE_DIR)/animatedarray.pde $(PDE_DIR)/utils.pde $(PDE_DIR)/bubble.txt
	@@mkdir $(P5_DIR)/animation
	cp $(PDE_DIR)/animationtest.pde $(P5_DIR)/animation/animationtest.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/animation/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/animation/animationobject.pde
	cp $(PDE_DIR)/animation.pde $(P5_DIR)/animation/animation.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/animation/constants.pde
	cp $(PDE_DIR)/animatedcode.pde $(P5_DIR)/animation/animatedcode.pde
	cp $(PDE_DIR)/animatedarray.pde $(P5_DIR)/animation/animatedarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/animation/utils.pde
	cp $(PDE_DIR)/bubble.txt $(P5_DIR)/animation/bubble.txt


animatedarray-p5: p5-dir $(PDE_DIR)/animatedarraytest.pde $(PDE_DIR)/animatedarray.pde $(PDE_DIR)/utils.pde $(PDE_DIR)/constants.pde $(PDE_DIR)/animationinstruction.pde $(PDE_DIR)/animationobject.pde
	@@mkdir $(P5_DIR)/animatedarraytest
	cp $(PDE_DIR)/animatedarraytest.pde $(P5_DIR)/animatedarraytest/animatedarraytest.pde
	cp $(PDE_DIR)/animatedarray.pde $(P5_DIR)/animatedarraytest/animatedarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/animatedarraytest/utils.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/animatedarraytest/constatns.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/animatedarraytest/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/animatedarraytest/animationobject.pde

splitter-p5: p5-dir $(PDE_DIR)/splitter.pde $(PDE_DIR)/splittertest.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde
	@@mkdir $(P5_DIR)/splittertest
	cp $(PDE_DIR)/splittertest.pde $(P5_DIR)/splittertest/splittertest.pde
	cp $(PDE_DIR)/splitter.pde $(P5_DIR)/splittertest/splitter.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/splittertest/constants.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/splittertest/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/splittertest/animationobject.pde

indicator-p5: p5-dir $(PDE_DIR)/indicator.pde $(PDE_DIR)/indicatortest.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde
	@@mkdir $(P5_DIR)/indicatortest
	cp $(PDE_DIR)/indicatortest.pde $(P5_DIR)/indicatortest/indicatortest.pde
	cp $(PDE_DIR)/indicator.pde $(P5_DIR)/indicatortest/indicator.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/sindicatortest/constants.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/indicatortest/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/indicatortest/animationobject.pde

clean:
	@@rm -fr $(P5_DIR) 
