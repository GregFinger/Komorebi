PImage leafTex;
PShape leaves;
PShader dappShader;
PGraphics pg;

int windowWidth = 406;
int windowHeight = 720;

//import peasy.*;
//PeasyCam cam;

void setup() {
  size(1280, 720, P3D);
  //fullScreen(P3D);
  background(0);
  pg = createGraphics(windowWidth, windowHeight, P3D);
  float fov = PI/4.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*100.0);
  //ortho();
  //cam = new PeasyCam(this, float(width)/2, float(height)/2, 0, 1000); 
  dappShader = loadShader("leaffrag.glsl", "leafvert.glsl");
  dappShader.set("renderSize", float(windowWidth), float(windowHeight));  
  leafTex = loadImage("leaf.png");
  leaves = createLeaves(leafTex);
}

void draw() {

  // This first block renders everything correctly (a "window" surrounded by black)
  // except the leaves are blurry
  // The second commented block, the leaves are more crisp/sharp, but creating the "window"
  // might be a bit more complex to integrate

  pg.beginDraw();
  pg.translate(windowWidth/2, windowHeight/2); 
  pg.background(255, 250, 244);
  pg.shader(dappShader);
  dappShader.set("time", millis());
  pg.shape(leaves);
  pg.endDraw();
  image(pg, width/2 - (windowWidth/2), height/2 - (windowHeight/2));
/*
  translate(width/2, height/2); 
  background(255, 250, 244);
  shader(dappShader);
  dappShader.set("time", millis());
  shape(leaves);
*/
  String txt_fps = String.format(getClass().getName()+ "   [fps %6.2f]", frameRate);
  surface.setTitle(txt_fps);
}

PShape createLeaves(PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUADS);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= 144; i++) {
    sh.vertex(-10, -10, 0, 0);
    sh.vertex(10, -10, 1, 0);
    sh.vertex(10, 10, 1, 1);
    sh.vertex(-10, 10, 0, 1);
    sh.attrib("index", float(i) / 144.0);
  }
  sh.endShape(); 
  return sh;
}
