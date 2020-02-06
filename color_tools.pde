float[][] matXyz = {
  {0.4124, 0.3576, 0.1805}, 
  {0.2126, 0.7152, 0.0722}, 
  {0.0193, 0.1192, 0.9505}, 
};

float[][] matRgb = {
  { 3.2406, -1.5372, -0.4986}, 
  {-0.9689, 1.8758, 0.0415}, 
  { 0.0557, -0.2040, 1.0570}, 
};

// D65 / 2°
float[] refXyz = {95.047, 100.000, 108.883};

float[] tmpRgb = new float[3];
float[] tmpXyz = new float[3];


// converts Processing's color to array of [r, g, b]
void colorToRgb(color c, float[] rgb) {
  rgb[0] = red(c);
  rgb[1] = green(c);
  rgb[2] = blue(c);
}


// converts array array of [r, g, b] to Processing's color
color rgbToColor(float[] rgb) {
  return color(rgb[0], rgb[1], rgb[2]);
}


// converts Processing's color to CIELAB
// adapted from http://www.easyrgb.com/en/math.php
void colorToLab(color c, float[] lab) {
  colorToRgb(c, tmpRgb);

  for (int i = 0; i < 3; i++) {
    tmpRgb[i] /= 255;
    tmpRgb[i] = tmpRgb[i] > 0.04045 ? pow((tmpRgb[i] + 0.055) / 1.055, 2.4) : tmpRgb[i] / 12.92;
    tmpRgb[i] *= 100;
  }

  for (int i = 0; i < 3; i++) {
    tmpXyz[i] = 0;
    for (int j = 0; j < 3; j++) tmpXyz[i] += matXyz[i][j] * tmpRgb[j];
    tmpXyz[i] /= refXyz[i];
    tmpXyz[i] = tmpXyz[i] > 0.008856 ? pow(tmpXyz[i], 1.0 / 3.0) : 7.787 * tmpXyz[i] + 16.0 / 116.0;
  }

  lab[0] = 116 * tmpXyz[1] - 16;
  lab[1] = 500 * (tmpXyz[0] - tmpXyz[1]);
  lab[2] = 200 * (tmpXyz[1] - tmpXyz[2]);
}


// converts CIELAB to Processing's color
// adapted from http://www.easyrgb.com/en/math.php
color labToColor(float[] lab) {
  tmpXyz[1] = (lab[0] + 16) / 116;
  tmpXyz[0] = lab[1] / 500 + tmpXyz[1];
  tmpXyz[2] = tmpXyz[1]  - lab[2] / 200;

  for (int i = 0; i < 3; i++) {
    float v = pow(tmpXyz[i], 3);
    tmpXyz[i] = v > 0.008856 ? v : (tmpXyz[i] - 16.0 / 116.0) / 7.787;
    tmpXyz[i] *= refXyz[i] / 100;
  }

  for (int i = 0; i < 3; i++) {
    tmpRgb[i] = 0;
    for (int j = 0; j < 3; j++) tmpRgb[i] += matRgb[i][j] * tmpXyz[j];
    tmpRgb[i] =  tmpRgb[i] > 0.0031308 ? 1.055 * pow(tmpRgb[i], 1.0 / 2.4) - 0.055 : 12.92 * tmpRgb[i];
    tmpRgb[i] *= 255;
  }

  return color(tmpRgb[0], tmpRgb[1], tmpRgb[2]);
}
