WEB_DIR := web
PDE_DIR := $(WEB_DIR)/pde
P5_DIR  := p5


p5-dir: clean
	@@mkdir $(P5_DIR)

p5-all: p5-dir $(PDE_DIR) bubble-p5 insertion-p5 animarray-p5 utils-p5

bubble-p5: p5-dir $(PDE_DIR)/bubble.pde $(PDE_DIR)/animarray.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/bubble
	cp $(PDE_DIR)/bubble.pde $(P5_DIR)/bubble/bubble.pde
	cp $(PDE_DIR)/animarray.pde $(P5_DIR)/bubble/animarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/bubble/utils.pde

insertion-p5: p5-dir $(PDE_DIR)/insertion.pde $(PDE_DIR)/animarray.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/insertion
	cp $(PDE_DIR)/insertion.pde $(P5_DIR)/insertion/insertion.pde
	cp $(PDE_DIR)/animarray.pde $(P5_DIR)/insertion/animarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/insertion/utils.pde
	
animarray-p5: p5-dir $(PDE_DIR)/animarraytest.pde $(PDE_DIR)/animarray.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/animarraytest
	cp $(PDE_DIR)/animarraytest.pde $(P5_DIR)/animarraytest/animarraytest.pde
	cp $(PDE_DIR)/animarray.pde $(P5_DIR)/animarraytest/animarray.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/animarraytest/utils.pde

utils-p5: p5-dir $(PDE_DIR)/utiltest.pde $(PDE_DIR)/utils.pde
	@@mkdir $(P5_DIR)/utiltest
	cp $(PDE_DIR)/utiltest.pde $(P5_DIR)/utiltest/utiltest.pde
	cp $(PDE_DIR)/utils.pde $(P5_DIR)/utiltest/utils.pde
	
clean:
	@@rm -fr $(P5_DIR) 
