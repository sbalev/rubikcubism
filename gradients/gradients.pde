
void setup() {
  size(600, 320);
  background(255);
  
  color green = color(0, 255, 0);
  color blue = color(0, 0, 255);

  int steps = 20;
  float w = float(width) / steps;
  noStroke();
  
  // RGB gradient
  for (int i = 0; i < steps; i++) {
    color c = lerpColor(green, blue, i / (steps - 1.0));
    fill(c);
    rect(i * w, 0, w, 100);
  }
  
  // HSB gradient
  colorMode(HSB);
  float hGreen = hue(green);
  float hBlue = hue(blue);
  for (int i = 0; i < steps; i++) {
    color c = color(hGreen + (hBlue - hGreen) * i / (steps - 1.0), 255, 255);
    fill(c);
    rect(i * w, 220, w, 100);
  }
  
  // LAB gradient
  colorMode(RGB);
  float[] labGreen = new float[3];
  colorToLab(green, labGreen);
  float[] labBlue = new float[3];
  colorToLab(blue, labBlue);
  float[] lab = new float[3];
  
  for (int i = 0; i < steps; i++) {
    for (int j = 0; j < 3; j++) {
      lab[j] = labGreen[j] + (labBlue[j] - labGreen[j]) * i / (steps - 1.0);
      color c = labToColor(lab);
      fill(c);
      rect(i * w, 110, w, 100);
    }
  }
}
