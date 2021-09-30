PShader causticShader;

void setup(){
  size(1280,720,P3D);
  background(0);
  causticShader = loadShader("causticFrag.glsl");
}

void draw(){
  causticShader.set("time", millis());
  filter(causticShader);
  
  String txt_fps = String.format(getClass().getName()+ "   [fps %6.2f]", frameRate);
  surface.setTitle(txt_fps);  
}
