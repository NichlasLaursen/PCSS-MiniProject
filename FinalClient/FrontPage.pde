public class FrontPage extends Page {
  public FrontPage() {
    super("USERNAME");
    
    textFields.add(new TextField(new PVector(125, 225), new PVector(250, 50), "Username", "newConnection", Type.Username));
  }
}
