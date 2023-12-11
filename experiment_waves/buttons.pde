boolean is_commulative = false;
boolean is_recording = false;
ControlP5 cp5;

color start_recording_color = color(60, 179, 113);
color pause_recording_color = color(255, 0, 0);

void set_buttons(){
  cp5.addButton("resetter_button")
     .setPosition(10, 10)
     .setSize(80, 30)
     .setLabel("Reset base colors");
     
  cp5.addButton("commulative_button")
     .setPosition(10, 50)
     .setSize(80, 30)
     .setLabel("Accomulate contrasts");
     
  cp5.addButton("recording_button")
    .setPosition(10, 90)
    .setColorBackground(start_recording_color)
    .setLabel("Start recording")
    .setSize(80,30);
    
  cp5.addButton("stop_recording_button")
    .setPosition(10, 130)
    .setLabel("Save recording")
    .setSize(80,30);
    
}

void resetter_button() {
  for (int i = 0; i < pixels.length /2; i++) {
      float r = red(pixels[i]);
      float g = green(pixels[i]);
      float b = blue(pixels[i]);
      base_values[i] = r + g + b;
    }
}

void commulative_button() {
  is_commulative = !is_commulative;
}

void recording_button() {
  is_recording = !is_recording;
}

void stop_recording_button() {
  is_recording = false;
  save_video();
  delay(1000);
  exit();
}

void change_commulative(Button b){
  if (is_commulative){
    b.setLabel("Stop commulative");
  }
  else{
    b.setLabel("Accomulate contrasts");
  }
}

void change_recording(Button b){
  if (is_recording){
    b.setLabel("Pause recording");
    b.setColorBackground(pause_recording_color);
  }
  else{
    b.setLabel("Unpause recording");
    b.setColorBackground(start_recording_color);
  }
}

void controlEvent(ControlEvent event) {
  // Check if the event is triggered by the button
  if (event.isController() && event.getController().getName().equals("commulative_button")) {
    // Change the label of the button when pressed
    Button b = (Button) event.getController();
    change_commulative(b);
  }
  if (event.isController() && event.getController().getName().equals("recording_button")) {
    // Change the label of the button when pressed
    Button b = (Button) event.getController();
    change_recording(b);
  }
}
