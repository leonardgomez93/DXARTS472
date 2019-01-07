  
import processing.video.*;
import processing.serial.*; 


String val;    
PImage img1;
PImage img2;
PImage img3;
Capture cam;
long lastTime = 0;
int r1;
int r2;
int r3;
int r4;
int r5;
int count;
boolean forward;
Serial myPort;    
String inString;  
int lf = 10;      
int a = 0;
int random1;
int random2;
    
    
void setup() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600); 
  myPort.bufferUntil('\n'); 
  fullScreen();
  img3 = loadImage("eye1.png");
  img3.resize(width,height);
  count = 1;
  lastTime = millis();
  String[] cameras = Capture.list();
  r1 = int(random(1,27));
  r2 = int(random(50,251));
  r3 = int(random(1,3));
  r4 = int(random(0,3));
  r5 = int(random(1,21));
  random1 = int(random(1,11));
  random2 = int(random(1,11));
  forward = true;
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i] + "   " + str(i));
    }
    cam = new Capture(this, width, height, Capture.list()[15]);
    frameRate(60);
    cam.start(); 
    img1 = loadImage("a" + str(random1) + ".jpg"); 
    img1.resize(width,height);
    img2 = loadImage("b" + str(random2) + ".jpg"); 
    img2.resize(width,height);
    img2.blend(img1, 0, 0, width, height,0,0,width,height,DODGE);
    img2.blend(img3, 0, 0, width, height,0,0,width,height,OVERLAY);
  }      
}

void draw() {

  if (cam.available() == true) {
    cam.read();
  }
  if (millis() - lastTime > r2) {
    if(r3 == 1 && count <= 23) {
      for(int j = 0; j <= r4; j++) {
        count++;
      }  
    } else if(r3 == 2 && count >= 4) {
      for(int j = 0; j <= r4; j++) {
        count--;
      }  
    }
    if(count == r1) {
      r1 = int(random(1,27));
    }  
    img3 = loadImage("eye" + str(count) + ".png");
    r2 = int(random(25,251));
    lastTime = millis();
    r3 = int(random(1,3));
    r4 = int(random(0,3));
  }  
  
  image(cam, 0, 0);
  img3.resize(width,height);
  image(img3,0,0);
  tint(255, r5);
  image(img2, 0, 0, width, height);
  noTint();
  if (a == 1) {
    random1 = int(random(1,11));
    random2 = int(random(1,11));
    img1 = loadImage("a" + str(random1) + ".jpg"); 
    img1.resize(width,height);
    img2 = loadImage("b" + str(random2) + ".jpg"); 
    img2.resize(width,height);
    img2.blend(img1, 0, 0, width, height,0,0,width,height,DODGE);
    img2.blend(img3, 0, 0, width, height,0,0,width,height,OVERLAY);
    r5 = int(random(25,76));
  } 
  println(inString);
}

void serialEvent(Serial p) { 
  inString = p.readString();
  inString = inString.trim();
  if (inString.equals("1")) {
    a = 1;
  } 
} 