final float IDENTITY_THRESHOLD = 0.95;

PImage lisa;
ArrayList<QImage> lisas = new ArrayList();
int x = 0; 
int y = 0;

void setup() {
  size(1350, 660);
  frameRate(1200);
  background(0);
  
  lisa = loadImage("joconde1350x1980.jpg");
  lisa.resize(LISA_W, LISA_H);
}

void draw() {
  if (frameCount % 1000 == 0) println(frameCount);
  QImage nextLisa = new QImage(lisa, RUBIK_COLORS.length, RGB);
  nextLisa.changePalette(RUBIK_COLORS);
  
  boolean in = false;
  for (QImage l : lisas) {
    if (l.commonPixelsWith(nextLisa) > IDENTITY_THRESHOLD) {
      in = true;
      break;
    }
  }
  if (!in) {
    println("*", frameCount);
    lisas.add(nextLisa);
    nextLisa.display(x * LISA_W * 5, y * LISA_H * 5, 5);
    if (++x == 6) {
      x = 0;
      if (++y == 2) {
        save("many_lisas.png");
        noLoop();
      }
    }
  }
}
