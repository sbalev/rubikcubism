class KMeans {
  int n; // number of observations;
  int d; // dimension of each observation
  int k; // number of clusters
  
  float[][] observations; // dimension n x d
  int[] clusters; // cluster assigned to each observation, dimension n
  float[][] centroids; // dimension k x d
  
  int[] counts; // number of observations in each cluster, dimension k
  
  KMeans(float[][] observations, int clusterCount) {
    n = observations.length;
    d = observations[0].length;
    k = clusterCount;
    
    this.observations = observations;
    clusters = new int[n];
    centroids = new float[k][d];
    counts = new int[k];
    
    // start with random assignment
    for (int i = 0; i < n; i++) {
      clusters[i] = int(random(k));
    }
    updateCentroids();
  }
  
  void compute() {
    while(assignClusters()) updateCentroids();
  }
  
  int getCluster(int i) {
    return clusters[i];
  }
  
  float[] getCentroid(int c) {
    return centroids[c];
  }
  
  void updateCentroids() {
    for (int c = 0; c < k; c++) {
      fill(centroids[c], 0);
      counts[c] = 0;
    }
    for (int i = 0; i < n; i++) {
      add(centroids[clusters[i]], observations[i]);
      counts[clusters[i]]++;
    }
    for (int c = 0; c < k; c++) {
      mult(centroids[c], 1.0 / counts[c]);
    }
  }
  
  boolean assignClusters() {
    boolean newAssignment = false;
    for (int i = 0; i < n; i++) {
      int newCluster = getClosest(observations[i], centroids);
      if (newCluster != clusters[i]) {
        clusters[i] = newCluster;
        newAssignment = true;
      }
    }
    return newAssignment;
  } 
}


// returns the squared Euclidian distance between x and y
// x and y must have the same size
float sqDist(float[] x, float [] y) {
  float sqD = 0;
  for (int j = 0; j < x.length; j++) sqD += sq(x[j] - y[j]);
  return sqD;
}

// adds y to x
// x and y must have the same size
void add(float[] x, float[] y) {
  for (int j = 0; j < x.length; j++) x[j] += y[j];
}

// multiplies all elements of x by f
void mult(float[] x, float f) {
  for (int j = 0; j < x.length; j++) x[j] *= f;
}

// sets all elements of x to f
void fill(float[] x, float f) {
  for (int j = 0; j < x.length; j++) x[j] = f;
}

// returns the index of the element of ys closest (in Euclidian distance) to x 
int getClosest(float[] x, float[][] ys) {
  int iClosest = 0;
  float dMin = sqDist(x, ys[0]);
  for (int i = 1; i < ys.length; i++) {
    float d = sqDist(x, ys[i]);
    if (d < dMin) {
      iClosest = i;
      dMin = d;
    }
  }
  return iClosest;
}
