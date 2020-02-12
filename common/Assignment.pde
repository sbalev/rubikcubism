class Assignment {
  float[][] costs;
  int[] currentSolution;
  int[] bestSolution;
  float bestCost;
  
  Assignment(float[][] costs) {
    this.costs = costs;
    int n = costs.length;
    currentSolution = new int[n];
    bestSolution = new int[n];
    for (int i = 0; i < n; i++) {
      currentSolution[i] = bestSolution[i] = i;
    }
    bestCost = cost();
  }
  
  void compute() {
    while(nextPerm(currentSolution)) {
      float c = cost();
      if (c < bestCost) {
        bestCost = c;
        System.arraycopy(currentSolution, 0, bestSolution, 0, currentSolution.length);
      }
    }
  }
  
  float getCost() {
    return bestCost;
  }
  
  int getPair(int i) {
    return bestSolution[i];
  }
  
  float cost() {
    float c = 0;
    for (int i = 0; i < currentSolution.length; i++) {
      c += costs[i][currentSolution[i]];
    }
    return c;
  }
}

boolean nextPerm(int[] a) {
  int j, l, t;
  
  // Find the biggest j such that a[j] < a[j + 1]
  for (j = a.length - 2; j>= 0 && a[j] >= a[j + 1]; j--);
  // If not such j, stop, this is the last permutation
  if (j == -1) return false;
  // Find the biggest l such that a[j] < a[l]
  for (l = a.length - 1; a[j] >= a[l]; l--);
  // Swap a[j] and a[l]
  t = a[j]; a[j] = a[l]; a[l] = t;
  // Reverse a[j + 1] ... a[n - 1]
  for (j++, l = a.length - 1; j < l; j++, l--) {
    t = a[j]; a[j] = a[l]; a[l] = t;
  }
  return true;
}