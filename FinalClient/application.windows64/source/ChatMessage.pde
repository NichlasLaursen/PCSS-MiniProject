public class ChatMessage {
  private PVector position;
  private String message;
  private boolean myMessage;
  private float margin = 40;

  public ChatMessage(PVector position, String message, boolean myMessage) {
    this.position = position; 
    this.message = message;
    this.myMessage = myMessage;
  }
  
  public void addMargin() {
    position.y -= margin;
  }
  
  public void update() {
    if (myMessage) {
      fill(GREEN);
      textAlign(LEFT);
      text(username + " - " + message, position.x, position.y);
    } else {
      fill(color(BLUE));
      textAlign(RIGHT);
      text(message, position.x, position.y);
    }
  }
}
