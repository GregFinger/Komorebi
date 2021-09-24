float widthRatio = .333;
float heightRatio = 1;
float renderWidth;
float renderHeight;

PImage leafTex;
PShape leaves;
PShader leafShader;
PGraphics leafRender;
int leafCount = 144;
float leafSize = 0.05;

PShape frame;
PShape frameShader;
PGraphics frameRender;

void setup() {
  size(1280, 720, P3D);
  //fullScreen(P3D);
  renderWidth = width * widthRatio;
  renderHeight = height * heightRatio;  
  background(0);
  leafRender = createGraphics(int(renderWidth), int(renderHeight), P3D);
  leafShader = loadShader("leafFrag.glsl", "leafVert.glsl");
  leafShader.set("renderSize", renderWidth, renderHeight);  
  leafTex = loadImage("leaf-black.png");
  leaves = createLeaves(leafTex);
  
}

void draw() {
  leafRender.beginDraw();
  leafRender.perspective(degrees(60.0), renderWidth/renderHeight, 0.01, 1000.0);
  leafRender.camera(renderWidth/2, renderHeight/2, 1, renderWidth/2, renderHeight/2, 0, 0, 1, 0);
  leafRender.translate(renderWidth/2, renderHeight/2); 
  leafRender.background(255, 250, 244);
  leafRender.shader(leafShader);
  leafShader.set("time", millis());
  leafRender.shape(leaves);
  leafRender.endDraw();
  image(leafRender, width/2 - (renderWidth/2), height/2 - (renderHeight/2));

  String txt_fps = String.format(getClass().getName()+ "   [fps %6.2f]", frameRate);
  surface.setTitle(txt_fps);
}

PShape createLeaves(PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUADS);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= leafCount; i++) {
    sh.vertex(-leafSize, -leafSize, 0, 0, 0);
    sh.vertex(leafSize, -leafSize, 0, 1, 0);
    sh.vertex(leafSize, leafSize, 0, 1, 1);
    sh.vertex(-leafSize, leafSize, 0, 0, 1);
    sh.attrib("index", float(i));
  }
  sh.endShape(); 
  return sh;
}
