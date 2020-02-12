PImage lisa;

void setup() {
  size(2700, 1980);
  background(0);
  
  lisa = loadImage("joconde1350x1980.jpg");
  image(lisa, 1350, 0);
  lisa.resize(LISA_W, LISA_H);
}

void draw() {
}

void mousePressed() {
  QImage lisaQ = new QImage(lisa, RUBIK_COLORS.length, RGB);
  lisaQ.changePalette(RUBIK_COLORS);
  lisaQ.display(0, 0, LISA_PSIZE);
}
