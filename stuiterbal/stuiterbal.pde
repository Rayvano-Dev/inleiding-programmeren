int x = 50;
int y = 50;
int grote = 20;
int horspeed = 3;
float verspeed = 2.5;

void setup(){ 
  size(1000,500);
}

void draw(){
 y+= verspeed;

 if(y > 490){
   verspeed = 0;}
   

 if(y > 490){
   verspeed = -2.5;
   fill(255,0,0);}
  
   if(y < 10){
     verspeed = 2.5;
 fill(0,255,0);}
  
  x+= horspeed;
  background(0,0,0);
ellipse(x,y,grote,grote);

if(x > 990){
  horspeed = -3;
fill(0,0,255);}

if(x < 9){
  horspeed = 3;
  fill(80,0,90);}
}
