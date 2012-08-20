WEB_DIR := web
PDE_DIR := $(WEB_DIR)
P5_DIR  := p5


p5-dir: clean
	@@mkdir $(P5_DIR)

p5-all: p5-dir $(PDE_DIR) bubble-p5 insertion-p5 arrayanim-p5 utils-p5 code-p5

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
	
clean:
	@@rm -fr $(P5_DIR) 
