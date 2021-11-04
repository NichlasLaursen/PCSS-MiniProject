public class ChatPage extends Page {
  private Chat chat = new Chat(new PVector(0, 0), new PVector(500, 350));
  //private textFields.add(new TextField())
  
  public ChatPage() {
    super("CHAT");
    textFields.add(new TextField(new PVector(50, 425), new PVector(400, 50), "Message", "nextPage", Type.Chat));
  }
  
  public void update() {
    if (active) {
      super.update();
      chat.update();
      
      textAlign(CENTER);
      fill(GREEN);
      text("[" + "Room: " + room + "]", width/2, height/8);
      fill(color(BLACK));
      text("[" + username + "]", width/2, height/1.2);
    }
  }
  
  public Chat getChat () {
    return chat;
  }
  
}
