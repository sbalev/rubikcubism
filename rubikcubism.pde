final int LISA_W = 45;
final int LISA_H = 66;
final int LISA_PSIZE = 30;

color[] rubikColors = {
  #009B48, // green
  #B90000, // red
  #0045AD, // blue
  #FF5900, //orange
  #FFFFFF, // white
  #FFD500, // yellow
};

void setup() {
  size(2700, 1980);
  background(0);

  PImage lisa = loadImage("joconde1350x1980.jpg");
  lisa.resize(LISA_W, LISA_H);
  lisa.loadPixels();

  stroke(0);
  int i = 0;
  for (int y = 0; y < LISA_H; y++) {
    for (int x = 0; x < LISA_W; x++) {
      color c = lisa.pixels[i++];
      fill(c);
      rect(LISA_W * LISA_PSIZE + x * LISA_PSIZE, y * LISA_PSIZE, LISA_PSIZE, LISA_PSIZE, LISA_PSIZE / 6);
      fill(closestColor(c, rubikColors));
      rect(x * LISA_PSIZE, y * LISA_PSIZE, LISA_PSIZE, LISA_PSIZE, LISA_PSIZE / 6);
    }
  }
}


float distColor(color c1, color c2) {
  return dist(red(c1), green(c1), blue(c1), red(c2), green(c2), blue(c2));
}


color closestColor(color c, color[] palette) {
  int closest = 0;
  float dMin = distColor(c, palette[0]);
  
  for (int i = 1; i < palette.length; i++) {
    float d = distColor(c, palette[i]);
    if (d < dMin) {
      closest = i;
      dMin = d;
    }
  }
  
  return palette[closest];
}
