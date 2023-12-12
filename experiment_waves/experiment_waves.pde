import processing.video.*;
import controlP5.*;
import java.io.*;
import java.io.BufferedReader;
import java.util.Calendar;
import java.text.SimpleDateFormat;


int iteration = 0;

int w = 640;
int h = 360;

float[] base_values;

String formattedDateTime;

void setup() {
  size(640, 720);
  base_values = new float[w*h];
  background(255);
  initialize_camera();
  font = createFont("Arial", 12);
  fontBig = createFont("Arial", 18);
  set_initial_buttons();
  
  // Format the date and time
  Calendar calendar = Calendar.getInstance();
  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  formattedDateTime = dateFormat.format(calendar.getTime());
  
  create_time_folder();
  delay(400);
}

void draw() {
  if (!recording_finished){
    draw_prerecording();
  }
  else{
    draw_replay();
  }
  
  
}
