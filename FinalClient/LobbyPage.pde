public class LobbyPage extends Page {
    public LobbyPage() {
    super("SELECT LOBBY");
    buttons.add(new Button(new PVector(50, 250), new PVector(350, 50), "Lobby (1)", "setRoom1"));
    buttons.add(new Button(new PVector(50, 300), new PVector(350, 50), "Lobby (2)", "setRoom2"));
    buttons.add(new Button(new PVector(50, 350), new PVector(350, 50), "Lobby (3)", "setRoom3"));
    buttons.add(new Button(new PVector(50, 400), new PVector(350, 50), "Lobby (4)", "setRoom4"));
  }
}
