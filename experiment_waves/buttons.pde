boolean is_commulative = false;
boolean is_recording = false;
ControlP5 cp5;
boolean recording_finished = false;
boolean enable_sound_conversion = false;

color start_recording_color = color(60, 179, 113);
color pause_recording_color = color(255, 0, 0);

int button_width = 150;
int button_height = 30;
int button_separation = 10;
int current_start = 10;

PFont font;
PFont fontBig;

Button reset_button;
Button comm_button;
Button record_button;
Button stop_button;
Button sound_button;

Button convert_to_sound_button;


void set_initial_buttons(){
  cp5 = new ControlP5(this);
  
  reset_button = cp5.addButton("resetter_button")
     .setPosition(button_separation, current_start)
     .setSize(button_width, button_height)
     .setLabel("Reset contrasts");
     
  current_start += button_height + button_separation;
  comm_button = cp5.addButton("commulative_button")
     .setPosition(button_separation, current_start)
     .setSize(button_width, button_height)
     .setLabel("Accomulate black");
     
  current_start += button_height + button_separation;
  record_button = cp5.addButton("pause_recording_button")
    .setPosition(button_separation, current_start)
     .setSize(button_width, button_height)
    .setColorBackground(start_recording_color)
    .setLabel("Start recording");
    
  current_start += button_height + button_separation;
  stop_button = cp5.addButton("stop_recording_button")
    .setPosition(button_separation, current_start)
     .setSize(button_width, button_height)
    .setLabel("Save recording");
    
  current_start += button_height + button_separation;
  sound_button = cp5.addButton("enable_sound_conversion_button")
    .setPosition(button_separation, current_start)
     .setSize(button_width, button_height)
    .setLabel("Enable sound");
    
  reset_button.getCaptionLabel().setFont(font);
  comm_button.getCaptionLabel().setFont(font);
  record_button.getCaptionLabel().setFont(font);
  stop_button.getCaptionLabel().setFont(font);
  sound_button.getCaptionLabel().setFont(font);
  //sound_button.setVisible(false);
    
  //set_sound_buttons();
  //convert_to_sound_button.setVisible(false);
  
    
}

void resetter_button_handler() {
  for (int i = 0; i < pixels.length /2; i++) {
      float r = red(pixels[i]);
      float g = green(pixels[i]);
      float b = blue(pixels[i]);
      base_values[i] = r + g + b;
    }
}

void commulative_button_handler() {
  is_commulative = !is_commulative;
  change_commulative(comm_button);
}

void pause_recording_button_handler() {
  is_recording = !is_recording;
  change_recording(record_button);
}

void stop_recording_button_handler() {
  is_recording = false;
  save_video();
  delay(1000);
  recording_finished = true;
  if (!enable_sound_conversion){
    exit();
  }
}

void enable_sound_conversion_button_handler(){
  enable_sound_conversion = !enable_sound_conversion;
  change_sound_conversion(sound_button);
  
}

void change_commulative(Button b){
  if (is_commulative){
    b.setLabel("Stop commulative");
  }
  else{
    b.setLabel("Accomulate black");
  }
}

void change_recording(Button b){
  if (is_recording){
    b.setLabel("Pause recording");
    b.setColorBackground(pause_recording_color);
  }
  else{
    b.setLabel("Play recording");
    b.setColorBackground(start_recording_color);
  }
}

void change_sound_conversion(Button b){
  if (enable_sound_conversion){
    b.setLabel("Disable sound");
  }
  else{
    b.setLabel("Enable sound");
  }
}

void controlEvent(ControlEvent event) {
  println("ALOOOOO");
  if (event.isController()) {
    String name = event.getController().getName();
    println(name);
    
    if (name.equals("resetter_button")) {
      resetter_button_handler();
    }if (name.equals("commulative_button")) {
      commulative_button_handler();
    } else if (name.equals("pause_recording_button")) {
      pause_recording_button_handler();
    } else if (name.equals("stop_recording_button")) {
      if (!recording_finished){
        stop_recording_button_handler();
        hide_buttons();
        setup_sound_handler();
      }else{
        convert_sound_button_handler();
      }
      
    } else if (name.equals("enable_sound_conversion_button")) {
      enable_sound_conversion_button_handler();
    } else if (name.equals("convert_sound_button")) {
      convert_sound_button_handler();
    }
  }
}
  
void hide_buttons(){
  reset_button.setVisible(false);
  comm_button.setVisible(false);
  record_button.setVisible(false);
  stop_button.setVisible(false);
  sound_button.setVisible(false);
}

void set_sound_buttons(){
  //current_start += h + button_separation;
  //current_start = h + h/2;
  convert_to_sound_button = cp5.addButton("convert_sound_button")
     .setPosition(0, h)
     .setSize(w, h)
     .setLabel("Play sound from frame");
   convert_to_sound_button.getCaptionLabel().setFont(fontBig);
}

void convert_sound_button_handler(){
  convert_to_sound_button
  .setLabel("Playing sound...");
  wave_recording.pause();
  PImage screenshot = get(0, 0, w, h);
  screenshot.save(path_prefix + "frames/" + formattedDateTime + "_" + String.valueOf(sound_frame_iteration) + "_sound_frame.png");
  generate_sound();
  sound_frame_iteration += 1;
  exit();
  
  
}
