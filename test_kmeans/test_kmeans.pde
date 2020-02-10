int clusterCount = 3;
float[][] points = new float[100][2];
KMeans km;

void setup() {
  size(1600, 1600);
  for (int i = 0; i < points.length; i++) {
    points[i][0] = random(width);
    points[i][1] = random(height);
  }
  km = new KMeans(points, clusterCount);
  rectMode(CENTER);
}

void draw() {
  background(255);

  noStroke();
  colorMode(HSB, clusterCount);
  for (int i = 0; i < points.length; i++) {
    fill(km.getCluster(i), clusterCount, clusterCount);
    ellipse(points[i][0], points[i][1], 20, 20);
  }
  for (int c = 0; c < clusterCount; c++) {
    float[] centroid = km.getCentroid(c);
    fill(c, clusterCount, clusterCount);
    rect(centroid[0], centroid[1], 30, 30);
  }
  colorMode(RGB, 255);
}

void mousePressed() {
  if (!km.assignClusters()) {
    println("Algorithm converged");
  } else {
    km.updateCentroids();
  }
}
