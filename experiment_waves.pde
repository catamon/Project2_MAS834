import processing.video.*;

Movie myMovie;

int iteration = 0;

int w = 640;
int h = 360;

float[] base_values;

void setup() {
  size(640, 720);
  myMovie = new Movie(this, "exp3.mov");
  myMovie.loop(); // Start the video looping
  base_values = new float[w*h];
  delay(1000);
  background(255);
}

void draw() {
  image(myMovie, 0, 0, w, h);
  loadPixels();
  if (iteration == 0){
    for (int i = 0; i < pixels.length /2; i++) {
      float r = red(pixels[i]);
      float g = green(pixels[i]);
      float b = blue(pixels[i]);
      base_values[i] = r + g + b;
    }
    delay(1000);
  }
  
  for (int i = 0; i < pixels.length/2; i++){
      int y = floor(i/w) + h;
      int x = i % w;
      float r = red(pixels[i]);
      float g = green(pixels[i]);
      float b = blue(pixels[i]);
      float curr_brightness = r + g + b;
      float threshold = 30;
      int new_i = i + w*h;
      if (curr_brightness < base_values[i] - threshold){
        //set(x, y, color(0));
        pixels[new_i] = color(0);
      }
      else{
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

void movieEvent(Movie m) {
  m.read();
  //m.frameRate(0);
}

void keyPressed() {
  if (key == ' ') {
    if (myMovie.isPlaying()) {
      myMovie.pause();
    } else {
      myMovie.play();
    }
  }
}
