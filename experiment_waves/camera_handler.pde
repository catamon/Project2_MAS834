Capture cam;

void initialize_camera(){
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
}

void captureEvent(Capture c) {
  c.read();
}

void draw_prerecording(){
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
      float threshold =22;
      int new_i = i + w*h;
      if (curr_brightness < base_values[i] - threshold){
        pixels[new_i] = color(0);
      }
      //if (curr_brightness > base_values[i] + threshold){
      //  pixels[new_i] = color(0);
      //}
      else if (!is_commulative){
        pixels[new_i] = color(255);
      }
      
      //else if (curr_brightness > base_values[i] + threshold){
      //  //set(x, y, color(0));
      //  pixels[new_i] = color(0);
      //}
      
      //else if (curr_brightness > base_values[i] + threshold){
      //  //set(x, y, color(255));
      //  pixels[new_i] = color(255);
      //}
      //else{
      //  int grey = floor(curr_brightness /3);
      //  //set(x,y, color(grey));
      //  pixels[new_i] = color(grey);
      //}
  }
  updatePixels();
  if (is_recording){
    iteration += 1;
    PImage screenshot = get(0, h, w, h);
    screenshot.save(path_prefix + "frames/" + formattedDateTime + "/" + String.valueOf(iteration) + ".png");
  }
}
