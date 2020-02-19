PImage lisa;
QImage qLisa;
int cubeX = 0;
int cubeY = 0;

void setup() {
  size(1800, 1980);
  lisa = loadImage("joconde1350x1980.jpg");
  lisa.resize(45, 66);
  qLisa = new QImage(lisa, RUBIK_COLORS.length, RGB);
  qLisa.changePalette(RUBIK_COLORS);
  update();
}

void draw() {
}

void keyPressed() {
  int dx = 0, dy = 0;
  if (key == CODED) {
    if (keyCode == UP) {
      dy = -3;
    } else if (keyCode == DOWN) {
      dy = 3;
    } else if (keyCode == LEFT) {
      dx = -3;
    } else if (keyCode == RIGHT) {
      dx = 3;
    }
    cubeX = constrain(cubeX + dx, 0, LISA_W - 3);
    cubeY = constrain(cubeY + dy, 0, LISA_H - 3);
  } else if (key == ' ') {
    qLisa = new QImage(lisa, RUBIK_COLORS.length, RGB);
    qLisa.changePalette(RUBIK_COLORS);
  }
  update();
}

void mousePressed() {
  update();
}

void update() {
  background(0);
  qLisa.display(0, 0, LISA_PSIZE);
  noStroke();
  fill(0, 64);
  rect(cubeX * LISA_PSIZE, cubeY * LISA_PSIZE, 3 * LISA_PSIZE, 3 * LISA_PSIZE);
  
  qLisa.display((LISA_W + 3) * LISA_PSIZE, 0, cubeX, cubeY, 3, 3, 3 * LISA_PSIZE);
}
