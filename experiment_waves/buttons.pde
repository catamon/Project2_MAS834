boolean is_commulative = false;
//boolean reset_base_values = true;

void set_buttons(){
  cp5.addButton("resetter_button")
     .setPosition(10, 10)
     .setSize(80, 30)
     .setLabel("Reset base colors");
  cp5.addButton("commulative_button")
     .setPosition(10, 50)
     .setSize(80, 30)
     .setLabel("Accomulate contrasts");
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
