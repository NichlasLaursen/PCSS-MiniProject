class Interactable { 
  PVector position, size;
  String text, methodToRun;
  color normalColour = #F0F0F0; 
  color hoverColor = #D3D3D3; 
  color textColor = #FF6767;
  int textSize = 18;
  
  boolean isHovering;
  
  void update() {
    textAlign(CENTER, CENTER);
    fill(overBox()? hoverColor : normalColour);
    rect(position.x, position.y, size.x, size.y);
    
    fill(textColor);
    textSize(textSize);
    text(text, position.x + size.x/2, position.y + size.y/2);
  }
  
  void click() {
    if (overBox()) {
      method(methodToRun);
      println("Interactable");
    }
  }

  public boolean overBox() {
    return isHovering = mouseX > position.x & mouseX < position.x + size.x 
    & mouseY > position.y & mouseY < position.y + size.y;
  }
}
