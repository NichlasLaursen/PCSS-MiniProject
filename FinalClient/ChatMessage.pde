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
    position.y -= margin;
  }
  
  public void update() {
    fill(color(0,255,0));
    
    if (myMessage) {
      textAlign(LEFT);
      text(username + " - " + message, position.x-width+margin, position.y);
    } else {
      textAlign(RIGHT);
      text(message + " - " + username, position.x, position.y);
    }
    
    //text(message, position.x, position.y);
    //textAlign(LEFT);
    //text(username + ":", position.x-width+margin, position.y);
  }
}
