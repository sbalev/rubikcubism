final int LISA_W = 45;
final int LISA_H = 66;
final int LISA_PSIZE = 30;

size(2700, 1980);
background(0);

PImage lisa = loadImage("joconde1350x1980.jpg");
image(lisa, 1350, 0);
lisa.resize(LISA_W, LISA_H);
lisa.loadPixels();

stroke(0);
int i = 0;
for (int y = 0; y < LISA_H; y++) {
  for (int x = 0; x < LISA_W; x++) {
    fill(lisa.pixels[i++]);
    rect(x * LISA_PSIZE, y * LISA_PSIZE, LISA_PSIZE, LISA_PSIZE, LISA_PSIZE / 6);
  }
}
