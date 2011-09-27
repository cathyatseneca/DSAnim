WEB_DIR := web
PDE_DIR := $(WEB_DIR)/pde
P5_DIR  := p5


p5-dir: clean
	@@mkdir $(P5_DIR)

p5-all: p5-dir $(PDE_DIR) bubble-p5 insertion-p5

bubble-p5: p5-dir $(PDE_DIR)/bubble.pde $(PDE_DIR)/animarray.pde
	@@mkdir $(P5_DIR)/bubble
	cp $(PDE_DIR)/bubble.pde $(P5_DIR)/bubble/bubble.pde
	cp $(PDE_DIR)/bubble.pde $(P5_DIR)/bubble/animarray.pde

insertion-p5: p5-dir $(PDE_DIR)/insertion.pde $(PDE_DIR)/animarray.pde
	@@mkdir $(P5_DIR)/insertion
	cp $(PDE_DIR)/insertion.pde $(P5_DIR)/insertion/insertion.pde
	cp $(PDE_DIR)/insertion.pde $(P5_DIR)/insertion/animarray.pde
	
	
clean:
	@@rm -fr $(P5_DIR) 
