public class Page {
  public color bckColour = color(200,200,200);
  public color textColour = color(255, 255, 255);
  public String title;
  public boolean active = false;
  
  public ArrayList<Chat> chats = new ArrayList<Chat>();
  public ArrayList<Button> buttons = new ArrayList<Button>();
  public ArrayList<TextField> textFields = new ArrayList<TextField>();
  
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
