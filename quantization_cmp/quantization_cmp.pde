final int LAB = RGB + 1;

void setup() {
  size(1350, 1980);
  background(0);
  PImage lisa = loadImage("joconde1350x1980.jpg");
  
  QImage lisa11 = new QImage(lisa, RUBIK_COLORS.length, RGB);
  lisa11.shrink(LISA_PSIZE);
  lisa11.display(0, 0, LISA_PSIZE / 2);
  
  //lisa11.display(675, 0, LISA_PSIZE / 2);

  QImage lisa12 = new QImage(lisa, RUBIK_COLORS.length, LAB);
  lisa12.shrink(LISA_PSIZE);
  lisa12.display(LISA_W * LISA_PSIZE / 2, 0, LISA_PSIZE / 2);
  
  lisa.resize(LISA_W, LISA_H);
  
  QImage lisa21 = new QImage(lisa, RUBIK_COLORS.length, RGB);
  lisa21.display(0, LISA_H * LISA_PSIZE / 2, LISA_PSIZE / 2);

  QImage lisa22 = new QImage(lisa, RUBIK_COLORS.length, LAB);
  lisa22.display(LISA_W * LISA_PSIZE / 2, LISA_H * LISA_PSIZE / 2, LISA_PSIZE / 2);
}
