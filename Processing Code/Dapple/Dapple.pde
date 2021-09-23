PImage leafTex;
PShape leaves;
PShader dappShader;
PGraphics pg;

float widthRatio = .333;
float heightRatio = 1;

float renderWidth;
float renderHeight;

float leafSize = 0.05;

void setup() {
  size(1280, 720, P3D);
  //fullScreen(P3D);
  renderWidth = width * widthRatio;
  renderHeight = height * heightRatio;  
  background(0);
  pg = createGraphics(int(renderWidth), int(renderHeight), P3D);
  dappShader = loadShader("leaffrag.glsl", "leafvert.glsl");
  dappShader.set("renderSize", renderWidth, renderHeight);  
  leafTex = loadImage("leaf-black.png");
  leaves = createLeaves(leafTex);
}

void draw() {

  // This first block renders everything correctly (a "window" surrounded by black)
  // except the leaves are blurry
  // The second commented block, the leaves are more crisp/sharp, but creating the "window"
  // might be a bit more complex to integrate

  pg.beginDraw();
  pg.perspective(degrees(60.0), renderWidth/renderHeight, 0.01, 1000.0);
  pg.camera(renderWidth/2, renderHeight/2, 1, renderWidth/2, renderHeight/2, 0, 0, 1, 0);
  pg.translate(renderWidth/2, renderHeight/2); 
  pg.background(255, 250, 244);
  pg.shader(dappShader);
  dappShader.set("time", millis());
  pg.shape(leaves);
  pg.endDraw();
  image(pg, width/2 - (renderWidth/2), height/2 - (renderHeight/2));
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
    sh.vertex(-leafSize, -leafSize, 0, 0, 0);
    sh.vertex(leafSize, -leafSize, 0, 1, 0);
    sh.vertex(leafSize, leafSize, 0, 1, 1);
    sh.vertex(-leafSize, leafSize, 0, 0, 1);
    sh.attrib("index", float(i) / 144.0);
  }
  sh.endShape(); 
  return sh;
}
