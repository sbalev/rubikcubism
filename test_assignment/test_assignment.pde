void setup() {
  size(600, 200);

  PImage lisa = loadImage("joconde1350x1980.jpg");
  lisa.resize(LISA_W, LISA_H);
  
  int k = RUBIK_COLORS.length;
  QImage lisaQ = new QImage(lisa, k, RGB);
  
  // compute cost matrix
  float[][] costs = new float[k][k];
  float[][] lisaRgb = new float[k][3];
  float[][] rubikRgb = new float[k][3];
  
  for (int c = 0; c < k; c++) {
    colorToRgb(lisaQ.palette[c], lisaRgb[c]);
    colorToRgb(RUBIK_COLORS[c], rubikRgb[c]);
  }
  
  for (int i = 0; i < k; i++) {
    for (int j = 0; j < k; j++) {
      costs[i][j] = sqrt(sqDist(lisaRgb[i], rubikRgb[j]));
    }
  }
  
  // assign Rubik colors to Lisa's palette
  Assignment ass = new Assignment(costs);
  ass.compute();
  
  // display the assignment
  for (int c = 0; c < k; c++) {
    fill(lisaQ.palette[c]);
    rect(100 * c, 0, 100, 100);
    fill(RUBIK_COLORS[ass.getPair(c)]);
    rect(100 * c, 100, 100, 100);
  }
}
