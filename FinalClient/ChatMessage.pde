public class ChatMessage {
  PVector position;
  String message;
  boolean myMessage;
  float margin = 40;

  public ChatMessage(PVector position, String message, boolean myMessage) {
    this.position = position; 
    this.message = message;
    this.myMessage = myMessage;
  }
  
  public void addMargin() {
    position.y += margin;
  }
  
  public void update() {
    if (myMessage) {
      textAlign(LEFT);
    } else {
      textAlign(RIGHT);
    }
    fill(color(0,255,0));
    text(message, position.x, position.y);
  }
}
