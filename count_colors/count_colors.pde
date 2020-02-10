import java.util.HashSet;

HashSet<Integer> colors = new HashSet();

PImage lisa = loadImage("joconde1350x1980.jpg");
lisa.loadPixels();
for (int i = 0; i < lisa.pixels.length; i++) {
  colors.add(lisa.pixels[i]);
}

println(colors.size());
