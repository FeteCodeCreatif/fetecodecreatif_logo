int gridSize = 75;
int hsize = 3;
int wsize = 4;
int w = gridSize*(wsize+2);
int h = gridSize*(hsize+2);
float pas = gridSize/25;

int[] coordx = new int[wsize];
int[] coordy = new int[hsize];

color[] c = new color[4];

Agent bleu;
Agent jaune;
Agent magenta;
Agent blanc;

void setup() {
  colorMode(RGB, 255, 255, 255, 100);
  size(200, 200);
  surface.setResizable(true);
  surface.setSize(int(w), int(h));
  background(255);
  strokeWeight(2);
  
  frameRate(60);
  
  c[0] = color(130, 200, 230);
  c[1] = color(255, 201, 52);
  c[2] = color(255, 0, 60);
  c[3] = color(255, 255, 255);

  for(int k = 0 ; k < coordx.length ; k++){
    coordx[k] = gridSize*(k+1);
  }
  for(int l = 0 ; l < coordy.length ; l++){
    coordy[l] = gridSize*(l+1);
  }

  bleu = new Agent(coordx[int(random(coordx.length))], coordy[int(random(coordy.length))], c[0], 10);
  jaune = new Agent(coordx[int(random(coordx.length))], coordy[int(random(coordy.length))], c[1], 10);
  magenta = new Agent(coordx[int(random(coordx.length))], coordy[int(random(coordy.length))], c[2], 10);
  blanc = new Agent(coordx[int(random(coordx.length))], coordy[int(random(coordy.length))], c[3], 14);
}

void draw() {
  //fill(255, 255, 255, 1);
  //rect(0, 0, w, h);
 /* noFill();
  stroke(215);
  for (int i = gridSize; i <= (gridSize*wsize); i++) {
    if (i%gridSize==0) {
      for (int j = gridSize; j <= (gridSize*hsize); j++) {
        if (j%gridSize==0) {
          rect(i, j, gridSize, gridSize);
          //line(i, j, i+gridSize, j+gridSize);
          line(i+gridSize, j, i, j+gridSize);
        }
      }
    }
  }*/

  blanc.run();
  bleu.run();
  jaune.run();
  magenta.run();
  
  
  saveFrame("frames/####.png");
  
  /*fill(0);
  text(mouseX, mouseX+10, mouseY+10);
  text(mouseY, mouseX+30, mouseY+10);*/
  
}

class Agent {
  float posx;
  float posy;
  int rad;
  boolean once = false;
  int choice = 0;
  int prev = 0;
  int tmp;
  color col;

  Agent(float x, float y, color c, int r) {
    posx = x;
    posy = y;
    col = c;
    rad = r;
  }
  
  void init () {
    if (!once) {
      direction();
      println("INIT : "+choice);
      once = true;
    }
  }

  void update() {
    if (choice == 0 && prev != 3) { 
      posy += pas;
    } else if (choice == 1  && prev != 4) { 
      posy += pas/2; 
      posx -= pas/2;
    } else if (choice == 2 && prev != 5) { 
      posx -= pas;
    } else if (choice == 3 && prev != 0) { 
      posy -= pas;
    } else if (choice == 4 && prev != 1) { 
      posy -= pas/2;
      posx += pas/2;
    } else if (choice == 5 && prev != 2) { 
      posx += pas;
    } else {
      prev = choice;
      direction(); 
    }
    
    if (posx%gridSize == 0 && posy%gridSize == 0) {
      prev = choice;
      direction();
    } 
  }

  void direction() {
    //println("direction");
    tmp = int(random(6));
    
     if(tmp == 0){
       if(posy >= gridSize*(hsize+1)){
           direction();
       }
     }
     else if(tmp == 1){
       if(posy >= gridSize*(hsize+1) || posx <= gridSize){
           direction();
       }
     }
     else if(tmp == 2){
       if(posx <= gridSize){
           direction();
       }
     }
     else if(tmp == 3){
       if(posy <= gridSize){
           direction();
       }
     }
     else if(tmp == 4){
       if(posy <= gridSize || posx >= gridSize*(wsize+1)){
           direction();
       }
     }
     else if(tmp == 5){
       if(posx >= gridSize*wsize){
           direction();
       }
     }
     choice = tmp;
  }

  void display() {
    noStroke();
    //stroke(255);
    fill(col);
    ellipse(posx, posy, rad, rad);
  }

  void run() {
    init();
    update();
    display();
  }
}