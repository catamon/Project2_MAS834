Movie wave_recording;

int sound_frame_iteration = 0;


void setup_sound_handler(){
  //delay(5000);
  wave_recording = new Movie(this, "../frames/" + formattedDateTime + ".mp4");
  wave_recording.loop();
  //convert_to_sound_button.setVisible(true);
  set_sound_buttons();
}

void draw_replay(){
  background(255);
  image(wave_recording, 0, 0, w, h);
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  if (key == ' ') {
    if (wave_recording.isPlaying()) {
      wave_recording.pause();
    } else {
      wave_recording.play();
    }
  }
}
