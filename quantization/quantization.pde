PImage lisa;
KMeans km;

void setup() {
  size(2700, 1980);
  lisa = loadImage("joconde1350x1980.jpg");
  image(lisa, 1350, 0);
  lisa.loadPixels();

  // Prepare data for k-means
  float[][] arrPixels = new float[lisa.pixels.length][3];
  for (int i = 0; i < lisa.pixels.length; i++) {
    colorToRgb(lisa.pixels[i], arrPixels[i]);
  }
  
  km = new KMeans(arrPixels, RUBIK_COLORS.length);
}

void draw() {
  println("Iteration ", frameCount);
  lisa.loadPixels();
  for (int i = 0; i < lisa.pixels.length; i++) {
    lisa.pixels[i] = rgbToColor(km.getCentroid(km.getCluster(i)));
  }
  lisa.updatePixels();
  image(lisa, 0, 0);
  stroke(0);
  for (int c = 0; c < RUBIK_COLORS.length; c++) {
    fill(rgbToColor(km.getCentroid(c)));
    rect(100 * c, 0, 100, 100);
  }
  
  if (km.assignClusters()) {
    km.updateCentroids();
  } else {
    println("Algorithm converged");
    noLoop();
  }
}
