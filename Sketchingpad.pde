/** @peep sketchcode */
/*This sketchpad is designed for kids T-shirts and Hoodies
  click the button at bottom to change background color
  click the button at top to selector a tool*/

//load the T-shirt shape image and pencil cursor
PImage img;
PImage pen;
//because we want to constrain the canvas size
//so use mx, my to save current position of mouse
//and pmx, pmy the previous position of mouse
float mx, my, pmx, pmy;
//instead of drawing directly, add an easing effect
float targetX, targetY;
char tool = 'L';
//we will draw on the foregroundLayer 
PGraphics foregroundLayer;
//the backgroundLayer is the canvas
PGraphics backgroundLayer;
//mycolor is the current color we are drawing
color mycolor;

//these button to change background color of the canvas
//totally eight color can we choose from
Button c0 = new Button(40, 625, 20, color(255,255,255));
Button c1 = new Button(100, 625, 20, color(255,140,140));
Button c2 = new Button(160, 625, 20, color(255,250,140));
Button c3 = new Button(220, 625, 20, color(140,255,140));
Button c4 = new Button(280, 625, 20, color(140,255,250));
Button c5 = new Button(340, 625, 20, color(140,140,255));
Button c6 = new Button(400, 625, 20, color(220,140,255));
Button c7 = new Button(460, 625, 20, color(180,180,180));

//tools button
Button t0 = new Button(20, 20, 25, color(255,255,255));
Button t1 = new Button(60, 20, 25, color(255,255,255));
Button t2 = new Button(100, 20, 25, color(255,255,255));
Button t3 = new Button(140, 20, 25, color(255,255,255));
Button t4 = new Button(180, 20, 25, color(255,255,255));
Button t5 = new Button(220, 20, 25, color(255,255,255));

Button mirror = new Button(260, 60, 25, color(255,255,255));
Button clear = new Button(300, 60, 25, color(255,255,255));

void setup() {
  img = loadImage("11.png");
  pen = loadImage("00.png");
  cursor(pen, 0, pen.height-1);
  
  //divide the sketch into different parts
  colorMode(HSB);
  size(500, 650);
  background(255);
  fill(50);
  noStroke();
  rect(0,0,500,100);
  rect(0,600,500,50);
  smooth();

  foregroundLayer = createGraphics(width, height); 
  //we only need 500*500 for our background layer
  backgroundLayer = createGraphics(width, height);
  backgroundLayer.beginDraw();
  backgroundLayer.fill(255,255,255);
  backgroundLayer.rect(0,100,500,500);
  backgroundLayer.endDraw();

  //default is white
  c0.clicked = true;
  //default is Line  
  t0.clicked = true;
  
  colorselector(380,50);
  mycolor = color(0,0,0);
}
 
void draw() {
  //constrain the sketchpad  
  mx = constrain(mx, 0, 500);
  my = constrain(my, 110, 590);
  pmx = constrain(pmx, 0, 500);
  pmy = constrain(pmy, 110, 590);
  targetX = constrain(targetX, 0, 500);
  targetY = constrain(targetY, 110, 590);

  //clear previous button state
  //we draw a rectangle on the screen everytime, else when 
  //the button becomes bigger when clicked, when it becomes 
  //smaller we cannot see the effect because the bigger one
  //still remains on the screen.
  fill(50);
  noStroke();
  rect(0,0,330,100);
  rect(0,600,500,50);
  
  //add background-color buttons
  c0.drawcirclebutton();
  c1.drawcirclebutton();
  c2.drawcirclebutton();
  c3.drawcirclebutton();
  c4.drawcirclebutton();
  c5.drawcirclebutton();
  c6.drawcirclebutton();
  c7.drawcirclebutton();

  //add tools button
  t0.drawrectbutton();
  t1.drawrectbutton();
  t2.drawrectbutton();
  t3.drawrectbutton();
  t4.drawrectbutton();
  t5.drawrectbutton();
  
  mirror.drawrectbutton();
  clear.drawrectbutton();

  //select a drawing color, default is black
  selectcolor();
  
  //draw the sketch
  foregroundLayer.beginDraw();
  if (tool == 'L') {
      if (mx != targetX || my != targetY) {
      pmx = mx;
      pmy = my;
      mx = mx + 0.1 * (targetX - mx);
      my = my + 0.1 * (targetY - my);
      foregroundLayer.stroke(mycolor);
      foregroundLayer.strokeWeight(dist(pmx, pmy, mx, my) * 0.2);
      foregroundLayer.line(pmx, pmy, mx, my);
      if(mirror.clicked == true) {
        //Draw a second line flipped in the horizontal axis
        foregroundLayer.line(width-pmx, pmy, width-mx, my);        
      }
    }
  }
  else if (tool == 'B') {
    if (mx != targetX || my != targetY) {
      pmx = mx;
      pmy = my;
      mx = mx + 0.1 * (targetX - mx);
      my = my + 0.1 * (targetY - my);
      foregroundLayer.fill(mycolor);
      foregroundLayer.stroke(mycolor);
      foregroundLayer.strokeWeight(20);
      foregroundLayer.line(pmx, pmy, mx, my);
      if(mirror.clicked == true) {
        foregroundLayer.line(width-pmx, pmy, width-mx, my);        
      }
    }
  }
  else if (tool == 'C') {
    if (mx != targetX || my != targetY) {
      foregroundLayer.fill(mycolor, random(100,255));
      foregroundLayer.noStroke();
      float temp = random(1,30);
      float xoff = random(-20,20);
      float yoff = random(-20,20);
      foregroundLayer.ellipse(mx+xoff,my+yoff,temp,temp);
      if(mirror.clicked == true) {
        foregroundLayer.ellipse(width-mx-xoff,my+yoff,temp,temp);
      }
    }
    mx = targetX;
    my = targetY;
  }
  else if (tool == 'T') {
    if (mx != targetX || my != targetY) {
      foregroundLayer.fill(mycolor, random(100,255));
      foregroundLayer.noStroke();
      float x1off = random(-20,20);
      float y1off = random(-20,20);      
      float x2off = random(-20,20);
      float y2off = random(-20,20); 
      float x3off = random(-20,20);
      float y3off = random(-20,20);
      foregroundLayer.triangle(mx+x1off,my+y1off,mx+x2off,my+y2off,mx+x3off,my+y3off);
      if(mirror.clicked == true) {
        foregroundLayer.triangle(width-mx-x1off,my+y1off,width-mx-x2off,my+y2off,width-mx-x3off,my+y3off);
      }
    }
    mx = targetX;
    my = targetY;
  }
  else if (tool == 'R') {
    if (mx != targetX || my != targetY) {
      foregroundLayer.fill(mycolor, random(100,255));
      foregroundLayer.noStroke();
      float xoff = random(-20,20);
      float yoff = random(-20,20);
      float w = random(5,20);
      float h = random(5,20);
      foregroundLayer.rect(mx+xoff,my+yoff,w,h);
      if(mirror.clicked == true) {
        foregroundLayer.rect(width-mx-xoff-w,my+yoff,w,h);
      }
    }
    mx = targetX;
    my = targetY;
  }
  else if (tool == 'H') {
    if (mx != targetX || my != targetY) {
      float tempx = mx + random(-20,20);
      float tempy = my + random(-20,20);
      float a = random(PI);
      float s = random(0.3,0.7);
      float t = random(100,255);
      foregroundLayer.pushMatrix();
      foregroundLayer.translate(tempx,tempy);
      foregroundLayer.rotate(a);
      foregroundLayer.scale(s);
      foregroundLayer.fill(mycolor, t);
      foregroundLayer.noStroke();
      foregroundLayer.beginShape();
      foregroundLayer.vertex(0, 0);
      foregroundLayer.bezierVertex(40, -20, 20, 20, 0, 40);
      foregroundLayer.vertex(0, 0);
      foregroundLayer.bezierVertex(-40, -20, -20, 20, 0, 40);
      foregroundLayer.endShape();
      foregroundLayer.popMatrix();
      
      if(mirror.clicked == true) {
        foregroundLayer.pushMatrix();
        foregroundLayer.translate(width-tempx,tempy);
        foregroundLayer.rotate(a);
        foregroundLayer.scale(s);
        foregroundLayer.fill(mycolor, t);
        foregroundLayer.noStroke();
        foregroundLayer.beginShape();
        foregroundLayer.vertex(0, 0);
        foregroundLayer.bezierVertex(40, -20, 20, 20, 0, 40);
        foregroundLayer.vertex(0, 0);
        foregroundLayer.bezierVertex(-40, -20, -20, 20, 0, 40);
        foregroundLayer.endShape();
        foregroundLayer.popMatrix();
      }
    }
    mx = targetX;
    my = targetY;
  }
  foregroundLayer.endDraw();

  image(backgroundLayer, 0, 0);
  image(foregroundLayer, 0, 0);
  
  image(img, 0, 0);
  
}

void colorselector(int x, int y) {
  pushMatrix();
  translate(x,y);
  for(int i = 0; i < 90; i++) {
    float bright = map(i, 0, 90, 255, 0);
    color b = color(bright);
    stroke(b);
    line(60,-45+i,80,-45+i);
  }
  for(float hh = 0; hh < 360; hh++) {
    for(float i = 0; i < 255; i++) {
      //when the radius is from 26 to 45 (150/255*45 == 26), we change Brightness
      //so the color dip into black
      float bb = map(i, 150, 255, 255, 50);
      // when the radius is from 0 to 26, we change Saturation
      //so the pie center start from white
      float ss = map(i, 0, 150, 0, 255);
      color cc = color(hh, ss, bb);
      stroke(cc);
      point((45.0/255)*i*sin(0.017453*hh),(45.0/255)*i*cos(0.017453*hh));
    }
  }
  popMatrix();
}

void selectcolor() {
  float disX = 380 - mouseX;
  float disY = 50 - mouseY;
  if(mousePressed) {
    if( (sqrt(sq(disX) + sq(disY)) < 45) || 
    (mouseX > 440 && mouseX < 460 && mouseY > 5 && mouseY < 90)) {
      mycolor = get(mouseX, mouseY);    
    }    
  }
  noStroke();
  fill(mycolor);
  rect(470,75,20,20);
}

class Button {
  float xpos, ypos, radius;
  color cc;
  boolean clicked;
  Button (float x, float y, float r, color c) {
    xpos = x;
    ypos = y;
    radius = r;
    cc = c;
    clicked = false;
  }
  //squire button, used for tools selector
  void drawrectbutton() {
    fill(255);
    noStroke();
    if(clicked == false) {
      rect(xpos, ypos, radius, radius);
    }
    else {
      rect(xpos-5, ypos-5, radius+10, radius+10);
    }
  }
  //check if the mouse is over the button, if true, return true
  boolean overrectbutton() {
    if(mouseX >= xpos && mouseX <= xpos+radius && 
      mouseY >= ypos && mouseY <= ypos+radius) {
      return true;
    }
    else {
      return false; 
    }
  }
  //circle button, used for background color selector
  void drawcirclebutton() {
    fill(cc);
    noStroke();
    if(clicked == false) {
      ellipse(xpos, ypos, radius, radius);
    }
    else {
      ellipse(xpos, ypos, radius+10, radius+10);
    }  
  }
  //check if the mouse is over the button, if true, return true
  boolean overcirclebutton() {
    float disX = xpos - mouseX;
    float disY = ypos - mouseY;
    if( sqrt(sq(disX) + sq(disY)) < radius/2 ) {
      return true;
    }
    else {
      return false; 
    }
  }
}

void mousePressed() {
  targetX = mouseX;
  targetY = mouseY;
  mx = targetX;
  my = targetY;
  pmx = mx;
  pmy = my;
}
 
void mouseDragged() {
  targetX = mouseX;
  targetY = mouseY;
}

void mouseClicked() {
    if(c0.overcirclebutton() == true) { //white
        backgroundLayer.beginDraw();
        backgroundLayer.fill(255,255,255);
        backgroundLayer.rect(0,100,500,500);
        backgroundLayer.endDraw();
        c0.clicked = true;
        c1.clicked = false;
        c2.clicked = false;
        c3.clicked = false;
        c4.clicked = false;
        c5.clicked = false;
        c6.clicked = false;
        c7.clicked = false;
    }
    else if(c1.overcirclebutton() == true) { //red
        backgroundLayer.beginDraw();
        backgroundLayer.fill(255,140,140);
        backgroundLayer.rect(0,100,500,500);
        backgroundLayer.endDraw();
        c0.clicked = false;
        c1.clicked = true;
        c2.clicked = false;
        c3.clicked = false;
        c4.clicked = false;
        c5.clicked = false;
        c6.clicked = false;
        c7.clicked = false;
    }
    else if(c2.overcirclebutton() == true) { //yellow
        backgroundLayer.beginDraw();
        backgroundLayer.fill(255,250,140);
        backgroundLayer.rect(0,100,500,500);
        backgroundLayer.endDraw();
        c0.clicked = false;
        c1.clicked = false;
        c2.clicked = true;
        c3.clicked = false;
        c4.clicked = false;
        c5.clicked = false;
        c6.clicked = false;
        c7.clicked = false;
    }
    else if(c3.overcirclebutton() == true) { //green
        backgroundLayer.beginDraw();
        backgroundLayer.fill(140,255,140);
        backgroundLayer.rect(0,100,500,500);
        backgroundLayer.endDraw();
        c0.clicked = false;
        c1.clicked = false;
        c2.clicked = false;
        c3.clicked = true;
        c4.clicked = false;
        c5.clicked = false;
        c6.clicked = false;
        c7.clicked = false;
    }
    else if(c4.overcirclebutton() == true) { //blue
        backgroundLayer.beginDraw();
        backgroundLayer.fill(140,255,250);
        backgroundLayer.rect(0,100,500,500);
        backgroundLayer.endDraw();
        c0.clicked = false;
        c1.clicked = false;
        c2.clicked = false;
        c3.clicked = false;
        c4.clicked = true;
        c5.clicked = false;
        c6.clicked = false;
        c7.clicked = false;
    }
    else if(c5.overcirclebutton() == true) { //indigo
        backgroundLayer.beginDraw();
        backgroundLayer.fill(140,140,255);
        backgroundLayer.rect(0,100,500,500);
        backgroundLayer.endDraw();
        c0.clicked = false;
        c1.clicked = false;
        c2.clicked = false;
        c3.clicked = false;
        c4.clicked = false;
        c5.clicked = true;
        c6.clicked = false;
        c7.clicked = false;
    }
    else if(c6.overcirclebutton() == true) { //purple
        backgroundLayer.beginDraw();
        backgroundLayer.fill(220,140,255);
        backgroundLayer.rect(0,100,500,500);
        backgroundLayer.endDraw();
        c0.clicked = false;
        c1.clicked = false;
        c2.clicked = false;
        c3.clicked = false;
        c4.clicked = false;
        c5.clicked = false;
        c6.clicked = true;
        c7.clicked = false;
    }
    else if(c7.overcirclebutton() == true) { //gray
        backgroundLayer.beginDraw();
        backgroundLayer.fill(180,180,180);
        backgroundLayer.rect(0,100,500,500);
        backgroundLayer.endDraw();
        c0.clicked = false;
        c1.clicked = false;
        c2.clicked = false;
        c3.clicked = false;
        c4.clicked = false;
        c5.clicked = false;
        c6.clicked = false;
        c7.clicked = true;
    }
    else if(t0.overrectbutton() == true) { //line
      tool = 'L';
      t0.clicked = true;
      t1.clicked = false;
      t2.clicked = false;
      t3.clicked = false;
      t4.clicked = false;
      t5.clicked = false;
    }
    else if(t1.overrectbutton() == true) { //brush
      tool = 'B';
      t0.clicked = false;
      t1.clicked = true;
      t2.clicked = false;
      t3.clicked = false;
      t4.clicked = false;
      t5.clicked = false;
    }
    else if(t2.overrectbutton() == true) { //circle
      tool = 'C';
      t0.clicked = false;
      t1.clicked = false;
      t2.clicked = true;
      t3.clicked = false;
      t4.clicked = false;
      t5.clicked = false;
    }
    else if(t3.overrectbutton() == true) { //triangle
      tool = 'T';
      t0.clicked = false;
      t1.clicked = false;
      t2.clicked = false;
      t3.clicked = true;
      t4.clicked = false;
      t5.clicked = false;
    }
    else if(t4.overrectbutton() == true) { //rect
      tool = 'R';
      t0.clicked = false;
      t1.clicked = false;
      t2.clicked = false;
      t3.clicked = false;
      t4.clicked = true;
      t5.clicked = false;
    }
    else if(t5.overrectbutton() == true) { //heart
      tool = 'H';
      t0.clicked = false;
      t1.clicked = false;
      t2.clicked = false;
      t3.clicked = false;
      t4.clicked = false;
      t5.clicked = true;
    }
    else if(mirror.overrectbutton() == true) {
      if(mirror.clicked == false) {
        mirror.clicked = true;
      }
      else {
        mirror.clicked = false;
      }
    }
    else if(clear.overrectbutton() == true) {
      foregroundLayer.clear();
    }
}