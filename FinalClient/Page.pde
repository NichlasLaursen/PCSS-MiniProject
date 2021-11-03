public class Page {
  color bckColour = color(200,200,200);
  color textColour = color(255, 255, 255);
  String title;
  boolean active = false;
  
  ArrayList<Chat> chats = new ArrayList<Chat>();
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<TextField> textFields = new ArrayList<TextField>();
  
  public Page (String title) {
    this.title = title;
  }
  
  public void setActive() {
    active = true;
  }
  
  public void setActive(boolean value) {
    active = value;
  }
  
  public void keyPress() {
    if (active) {
      for (TextField textField : textFields) { 
        textField.keypressed(key, keyCode);
        textField.keyPress();
      }
    }
    
  }
  
  public void click() {
    if (active) {
      for (Button button : buttons) { 
        button.click();
      }
      for (TextField textField : textFields) { 
        textField.click();
      }
    }
  }
  
  public void update() {
    if (active) {
      background(bckColour);
      fill(color(textColour));
      textAlign(LEFT);
      text(title, 10, 25);
    
      for (Chat chat : chats) { 
        chat.update();
      }     
      for (Button button : buttons) { 
        button.update();
      }
      for (TextField textField : textFields) { 
        textField.update();
      }
    }
  }
}  
