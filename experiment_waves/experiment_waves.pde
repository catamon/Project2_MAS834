import processing.video.*;
import controlP5.*;
import java.io.*;
import java.io.BufferedReader;
import java.util.Calendar;
import java.text.SimpleDateFormat;

Capture cam;


int iteration = 0;

int w = 640;
int h = 360;

float[] base_values;

String formattedDateTime;

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
  
  Calendar calendar = Calendar.getInstance();
  
  // Format the date and time
  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  formattedDateTime = dateFormat.format(calendar.getTime());
  
  create_time_folder();
    
  delay(400);
  
}

void draw() {
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
  if (is_recording){
    iteration += 1;
    PImage screenshot = get(0, h, w, h);
    screenshot.save(path_prefix + "frames/" + formattedDateTime + "/" + String.valueOf(iteration) + ".png");
  }
  
}

void captureEvent(Capture c) {
  c.read();
}






// sh file para crear los folders
// sh file para save video
// add functionality para start/pause video recording
// make stop save video by default
