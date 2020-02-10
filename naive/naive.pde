void setup() {
  size(4050, 1980);
  background(0);

  PImage lisa = loadImage("joconde1350x1980.jpg");
  image(lisa, 0, 0);

  lisa.resize(LISA_W, LISA_H);
  lisa.loadPixels();
  stroke(0);
  int i = 0;
  for (int y = 0; y < LISA_H; y++) {
    for (int x = 0; x < LISA_W; x++) {
      fill(lisa.pixels[i]);
      rect(1350 + x * LISA_PSIZE, y * LISA_PSIZE, LISA_PSIZE, LISA_PSIZE, LISA_PSIZE / 6);
      fill(closestColor(lisa.pixels[i++], rubikColors));
      rect(2700 + x * LISA_PSIZE, y * LISA_PSIZE, LISA_PSIZE, LISA_PSIZE, LISA_PSIZE / 6);
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
