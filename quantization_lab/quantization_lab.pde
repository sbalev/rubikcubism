void setup() {
  size(2700, 1980);
  PImage lisa = loadImage("joconde1350x1980.jpg");
  lisa.loadPixels();

  float[][] rgbPixels = new float[lisa.pixels.length][3];
  float[][] labPixels = new float[lisa.pixels.length][3];
  for (int i = 0; i < lisa.pixels.length; i++) {
    colorToRgb(lisa.pixels[i], rgbPixels[i]);
    colorToLab(lisa.pixels[i], labPixels[i]);
  }

  KMeans rgbKm = new KMeans(rgbPixels, RUBIK_COLORS.length);
  rgbKm.compute();
  KMeans labKm = new KMeans(labPixels, RUBIK_COLORS.length);
  labKm.compute();

  PImage rgbLisa = createImage(lisa.width, lisa.height, RGB);
  rgbLisa.loadPixels();
  PImage labLisa = createImage(lisa.width, lisa.height, RGB);
  labLisa.loadPixels();
  
  for (int i = 0; i < lisa.pixels.length; i++) {
    rgbLisa.pixels[i] = rgbToColor(rgbKm.getCentroid(rgbKm.getCluster(i)));
    labLisa.pixels[i] = labToColor(labKm.getCentroid(labKm.getCluster(i)));
  }
  
  rgbLisa.updatePixels();
  image(rgbLisa, 0, 0);

  labLisa.updatePixels();
  image(labLisa, 1350, 0);
  
  stroke(0);
  for (int c = 0; c < RUBIK_COLORS.length; c++) {
    fill(rgbToColor(rgbKm.getCentroid(c)));
    rect(100 * c, 0, 100, 100);
    fill(labToColor(labKm.getCentroid(c)));
    rect(1350 + 100 * c, 0, 100, 100);
  }
}
