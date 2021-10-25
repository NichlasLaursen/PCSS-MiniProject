class Message {
  int moveText= 40;
  PVector position;
  String messageText;
  
  public Message (PVector position, String messageText) {
    this.position = position;
    this.messageText = messageText;
  }
  
  public void Update () {
  text(messageText, position.x, position.y);
  }
  
  public void MoveUp () {
  position.y -= moveText;
  }
}
