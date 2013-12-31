WEB_DIR := web
PDE_DIR := $(WEB_DIR)
P5_DIR  := p5


p5-dir: clean
	@@mkdir $(P5_DIR)

p5-all: p5-dir $(PDE_DIR) bubble-p5 insertion-p5 arrayanim-p5 utils-p5 code-p5 animation-p5 animatedarray-p5

bubble-p5: p5-dir $(PDE_DIR)/bubble.pde $(PDE_DIR)/arrayanim.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/bubble
	cp $(PDE_DIR)/bubble.pde $(P5_DIR)/bubble/bubble.pde
	cp $(PDE_DIR)/arrayanim.pde $(P5_DIR)/bubble/arrayanim.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/bubble/utils.pde
	cp $(PDE_DIR)/code.pde $(P5_DIR)/bubble/code.pde

insertion-p5: p5-dir $(PDE_DIR)/insertion.pde $(PDE_DIR)/arrayanim.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/insertion
	cp $(PDE_DIR)/insertion.pde $(P5_DIR)/insertion/insertion.pde
	cp $(PDE_DIR)/arrayanim.pde $(P5_DIR)/insertion/arrayanim.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/insertion/utils.pde
	cp $(PDE_DIR)/code.pde $(P5_DIR)/insertion/code.pde
	
arrayanim-p5: p5-dir $(PDE_DIR)/arrayanimtest.pde $(PDE_DIR)/arrayanim.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/arrayanimtest
	cp $(PDE_DIR)/arrayanimtest.pde $(P5_DIR)/arrayanimtest/arrayanimtest.pde
	cp $(PDE_DIR)/arrayanim.pde $(P5_DIR)/arrayanimtest/arrayanim.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/arrayanimtest/utils.pde

utils-p5: p5-dir $(PDE_DIR)/utiltest.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/utiltest
	cp $(PDE_DIR)/utiltest.pde $(P5_DIR)/utiltest/utiltest.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/utiltest/utils.pde

code-p5: p5-dir $(PDE_DIR)/code.pde $(PDE_DIR)/codetest.pde
	@@mkdir $(P5_DIR)/codetest
	cp $(PDE_DIR)/codetest.pde $(P5_DIR)/codetest/codetest.pde
	cp $(PDE_DIR)/code.pde $(P5_DIR)/codetest/code.pde

animation-p5: p5-dir $(PDE_DIR)/animation.pde $(PDE_DIR)/animationobject.pde $(PDE_DIR)/animationinstruction.pde $(PDE_DIR)/animatedarray.pde $(PDE_DIR)/utils.pde $(PDE_DIR)/bubble.txt
	@@mkdir $(P5_DIR)/animation
	cp $(PDE_DIR)/animationtest.pde $(P5_DIR)/animation/animationtest.pde
	cp $(PDE_DIR)/animationinstruction.pde $(P5_DIR)/animation/animationinstruction.pde
	cp $(PDE_DIR)/animationobject.pde $(P5_DIR)/animation/animationobject.pde
	cp $(PDE_DIR)/animation.pde $(P5_DIR)/animation/animation.pde
	cp $(PDE_DIR)/constants.pde $(P5_DIR)/animation/constants.pde
	cp $(PDE_DIR)/code.pde $(P5_DIR)/animation/code.pde
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

clean:
	@@rm -fr $(P5_DIR) 
