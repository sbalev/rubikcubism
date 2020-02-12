int[] a = new int[4];

void setup() {
  for (int i = 0; i < a.length; i++) a[i] = i;
}

void draw() {
  println(java.util.Arrays.toString(a));
  if (!nextPerm(a)) noLoop();
}
