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
  image(lisa, 1350, 0);
  lisa.loadPixels();
  
  // Prepare data for k-means
  float[][] arrPixels = new float[lisa.pixels.length][];
  for (int i = 0; i < lisa.pixels.length; i++) {
    arrPixels[i] = colorToArray(lisa.pixels[i]);
  }
  
  // Run k-means
  KMeans km = new KMeans(arrPixels, rubikColors.length);
  km.compute();
  
  // use the palette found by k-means
  for (int i = 0; i < lisa.pixels.length; i++) {
    lisa.pixels[i] = arrayToColor(km.getCentroid(km.getCluster(i)));
  }

  lisa.updatePixels();
  image(lisa, 0, 0);
  
  stroke(0);
  for (int c = 0; c < rubikColors.length; c++) {
    fill(arrayToColor(km.getCentroid(c)));
    rect(c * 100, 0, 100, 100); 
  }
}


float[] colorToArray(color c) {
  float[] a = {red(c), green(c), blue(c)};
  return a;
}

color arrayToColor(float[] a) {
  return color(a[0], a[1], a[2]);
}
