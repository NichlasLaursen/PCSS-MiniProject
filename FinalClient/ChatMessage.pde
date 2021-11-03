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
    
    
    if (myMessage) {
      fill(color(0,255,0));
      textAlign(LEFT);
      text(username + " - " + message, position.x, position.y);
    } else {
      fill(color(100,100,255));
      textAlign(RIGHT);
      text(message, position.x, position.y);
    }
    
    //text(message, position.x, position.y);
    //textAlign(LEFT);
    //text(username + ":", position.x-width+margin, position.y);
  }
}
