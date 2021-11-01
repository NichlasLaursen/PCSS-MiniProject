public class Chat {
  private PVector position, size;
  private float margin = 10;
  private color colour = color(10,10,10);
  private ArrayList<ChatMessage> messages = new ArrayList<ChatMessage>();
  private Socket socket;
  private Client client;
  
  public Chat(PVector position, PVector size) {
    this.position = position;
    this.size = size;
    
    connectToServer();
  }
  
  public void update () {
    
    fill(colour); 
    rect(position.x, position.y, size.x, size.y);
  }
  
  public void sendMessage(String msg) {
    client.sendMessageNew(msg);
    receiveMessage(msg, true);
  }
  
  public void receiveMessage(String msg, boolean fromMe) {
    for (ChatMessage chatMessage : messages) { 
      chatMessage.addMargin();
    }
    
    PVector newPos;
    if (fromMe) {
      newPos = new PVector(margin, size.y + margin);
    } else {
      newPos = new PVector(size.x - margin, size.y + margin);
    }
    
    messages.add(new ChatMessage(newPos, msg, fromMe));
  }
  
  private void connectToServer () {
    try {
      socket = new Socket("localhost",8000);
      client = new Client(socket, username, room);
      client.listenForMessage();
    } catch (IOException e) {
  
    }
  }
}
