public class ChatPage extends Page {
  private Chat chat = new Chat(new PVector(0, 40), new PVector(500, 300));
  //private textFields.add(new TextField())
  
  public ChatPage() {
    super("CHAT");
    textFields.add(new TextField(new PVector(125, 425), new PVector(250, 50), "Username", "nextPage", Type.Chat));
  }
  
  public void update() {
    if (active) {
      super.update();
      chat.update();
      
    }
  }
  
  public Chat getChat () {
    return chat;
  }
  
}
