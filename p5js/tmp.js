var x=100;
function setup(){
	createCanvas(500,800);
}
function draw(){
	background(0,0,50);
stroke(175,0,80);
fill(175,0,80);
	ellipse(x,100,50,50);
	stroke(0,255,0);
	fill(0,255,0);
	ellipse(300,300,100,100);
	stroke(150,105,0);
	fill(150,105,0);
	rect(285,350,30,70);
	x=x+1;
	if (x==500){
		x=0;
	}
}
