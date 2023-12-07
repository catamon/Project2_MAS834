import processing.video.*;
import controlP5.*;

Capture cam;
ControlP5 cp5;

int iteration = 0;

int w = 640;
int h = 360;

float[] base_values;

void setup() {
  size(640, 720);
  base_values = new float[w*h];
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("No cameras found");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, cameras[1]);
    cam.start();
  }
  background(255);
  
  cp5 = new ControlP5(this);
  set_buttons();
}

void draw() {
  println(iteration);
  if (cam.available()) {
    cam.read();
  }
  image(cam, 0, 0, w, h);
  loadPixels();
  
  for (int i = 0; i < w*h; i++){
      int y = floor(i/w) + h;
      int x = i % w;
      float r = red(pixels[i]);
      float g = green(pixels[i]);
      float b = blue(pixels[i]);
      float curr_brightness = r + g + b;
      float threshold = 30;
      int new_i = i + w*h;
      if (curr_brightness < base_values[i] - threshold){
        pixels[new_i] = color(0);
      }
      else if (!is_commulative){
        pixels[new_i] = color(255);
      }
      
      //else if (curr_brightness > base_values[i] + threshold){
      //  //set(x, y, color(0));
      //  pixels[new_i] = color(0);
      //}
      
  //    else if (curr_brightness > base_values[i] + threshold){
  //      //set(x, y, color(255));
  //      pixels[new_i] = color(255);
  //    }
  //    else{
  //      int grey = floor(curr_brightness /3);
  //      //set(x,y, color(grey));
  //      pixels[new_i] = color(grey);
  //    }
  }
  updatePixels();
  iteration += 1;
}

void captureEvent(Capture c) {
  c.read();
}
