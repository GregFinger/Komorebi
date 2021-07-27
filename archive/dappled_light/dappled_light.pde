PImage img;

void setup() {
  size(1280, 720);
  imageMode(CENTER);
  img = loadImage("leaf.png");
}

void draw () {
  background(0);
  for (int i = 0; i < 144; i++) {
    float x = i % 16;
    x *= 80;
    x += 40;
    float y = floor(i / 16);
    y *= 80;
    y += 40;
    noiseDetail(3, 0.5);
    float noiseScale = 0.10;    
    float noiseVal = noise(x * noiseScale, y * noiseScale);
    //noiseDetail(8,0.65);    
    pushMatrix();
    translate(x, y);
    rotate(radians(noiseVal * 360));
    image(img, 0, 0, 1280/16, 720/9);
    popMatrix();
  }
}
