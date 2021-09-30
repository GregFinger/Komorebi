float widthRatio = .333;
float heightRatio = 1;
float renderWidth;
float renderHeight;

PImage leafTex;
PShape leaves;
PShader leafShader;
PGraphics leafRender;
int leafCount = 256;
float leafSize = 0.15;

PShape frame;
PGraphics frameRender;

PShader blurShader;
PShader vignetteShader;

void setup() {
  size(1280, 720, P3D);
  //fullScreen(P3D);
  renderWidth = width * widthRatio;
  renderHeight = height * heightRatio;  
  background(0);
  leafRender = createGraphics(int(renderWidth), int(renderHeight), P3D);
  leafShader = loadShader("leafFrag.glsl", "leafVert.glsl");
  leafTex = loadImage("leaf-black.png");
  leaves = createLeaves(leafTex);

  frameRender = createGraphics(int(renderWidth), int(renderHeight), P3D);
  frame = createFrame();
  
  blurShader = loadShader("blurFrag.glsl");
  blurShader.set("Directions",16.0);
  blurShader.set("Quality",4.0);  
  vignetteShader = loadShader("vignetteFrag.glsl");
  vignetteShader.set("size",0.7,0.8);
  vignetteShader.set("radius",45.0);
  vignetteShader.set("edgeSoftness",30.0);
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
  leafRender.filter(vignetteShader);
  blurShader.set("Size",9.0);   
  leafRender.filter(blurShader);
  leafRender.endDraw();
  image(leafRender, width/2 - (renderWidth/2), height/2 - (renderHeight/2));

  frameRender.beginDraw();
  frameRender.perspective(degrees(60.0), renderWidth/renderHeight, 0.01, 1000.0);
  frameRender.camera(renderWidth/2, renderHeight/2, 1, renderWidth/2, renderHeight/2, 0, 0, 1, 0);
  frameRender.translate(renderWidth/2, renderHeight/2); 
  frameRender.clear();
  frameRender.shape(frame);
  frameRender.filter(vignetteShader);
  blurShader.set("Size",7.0); 
  frameRender.filter(blurShader);  
  frameRender.endDraw();
  image(frameRender, width/2 - (renderWidth/2), height/2 - (renderHeight/2));

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

PShape createFrame() {
  textureMode(NORMAL);
  PShape sh = createShape(GROUP);
  PShape rail = createShape(RECT, -widthRatio, -0.02, widthRatio*2, 0.04);
  PShape dividerMid = createShape(RECT, -0.005, -heightRatio, 0.01, heightRatio * 2);
  PShape dividerTop = createShape(RECT, -widthRatio, (-heightRatio/4)+ 0.025, widthRatio*2, 0.01);
  PShape dividerBot = createShape(RECT, -widthRatio, (heightRatio/4) - 0.025, widthRatio*2, 0.01);
  rail.disableStyle();
  noStroke();
  fill(40);
  shape(rail, 0, 0);
  dividerMid.disableStyle();
  noStroke();
  fill(40);
  shape(dividerMid, 0, 0);
  dividerTop.disableStyle();
  noStroke();
  fill(40);
  shape(dividerTop, 0, 0);
  dividerBot.disableStyle();
  noStroke();
  fill(40);
  shape(dividerBot, 0, 0);
  sh.addChild(rail);
  sh.addChild(dividerMid);
  sh.addChild(dividerTop);
  sh.addChild(dividerBot);

  return sh;
}
