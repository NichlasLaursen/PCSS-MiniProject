class Interactable { 
  PVector position, size;
  String text, methodToRun;
  color normalColour = #F0F0F0; 
  color hoverColor = #D3D3D3; 
  color textColor = #FF6767;
  int textSize = 18;
  
  boolean isHovering;
  
  void update() {
    //Visual elements of interactable prompts
    textAlign(CENTER, CENTER);
    fill(overBox()? hoverColor : normalColour);
    rect(position.x, position.y, size.x, size.y);
    
    fill(textColor);
    textSize(textSize);
    text(text, position.x + size.x/2, position.y + size.y/2);
  }
  
  void click() {
    //Runs method if the interactable prompt is pressed
    if (overBox()) {
      method(methodToRun);
      //println("Interactable");
    }
  }

  //Boolean for checking if those is over the specified box
  public boolean overBox() {
    return isHovering = mouseX > position.x & mouseX < position.x + size.x 
    & mouseY > position.y & mouseY < position.y + size.y;
  }
}
