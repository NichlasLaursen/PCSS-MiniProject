import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Random; 
import java.io.*; 
import java.net.Socket; 
import java.nio.Buffer; 
import java.util.Scanner; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FinalClient extends PApplet {



Page[] pages = new Page[3];
String username, room;
int currPage = 0;

int GREEN = color (0, 255, 0);
int BLUE  = color (100, 100, 255);
int BLACK = color (10, 10, 10);
int GREY  = color (100, 100, 100);

public void setup () {
  
  
  setInitialData();
  
  pages[0] = new FrontPage();
  pages[1] = new LobbyPage();
  pages[2] = new ChatPage();
  
  pages[0].setActive();
}

public void draw () {
  updatePages();
}

public void mousePressed () {
  for (int i = 0; i < pages.length; i++) {
     pages[i].click();
  }
}

public void keyPressed() {   
  for (int i = 0; i < pages.length; i++) {
     pages[i].keyPress();
  }
}

public void setInitialData() {
  Random r = new Random();
  username = "Per" + r.nextInt(1000);
  room = "1";
}

public void updatePages() {
  for (int i = 0; i < pages.length; i++) {
    pages[i].update();
  }
}

public void nextPage() {
    currPage++;
    setPage(currPage);
}

public void setPage(int index) {
  if (index < pages.length) {
    for (int i = 0; i < pages.length; i++) {
      pages[i].setActive(false);
    }
    pages[index].setActive();
    redraw();
  }
}

//We couldn´t send room name as an argument starting a new thread, we know this is bad practice
public void setRoom1() {
  room = "1";
  newConnection();
}

public void setRoom2() {
  room = "2";
  newConnection();
}

public void setRoom3() {
  room = "3";
  newConnection();
}

public void setRoom4() {
  room = "4";
  newConnection();
}

public void newConnection() {
    if(pages[2] instanceof ChatPage) ((ChatPage)pages[2]).getChat().connectToServer(username, room);
    nextPage();
}
class Button extends Interactable { 
  
  Button(PVector position, PVector size, String text, String methodToRun) {
    this.position = position; 
    this.size = size; 
    this.text = text;
    this.methodToRun = methodToRun;
  }

  //Overides Interactable click method
  public void click() {
    if (overBox()) {
      method(methodToRun);
    }
  }
}
public class Chat {
  private PVector position, size;
  private float margin = 10;
  private int colour = color(10,10,10);
  private ArrayList<ChatMessage> messages = new ArrayList<ChatMessage>();
  private Socket socket;
  private Client client;
  
  public Chat(PVector position, PVector size) {
    this.position = position;
    this.size = size;
  }
  
  public void update () {  
    fill(colour); 
    rect(position.x, position.y, size.x, size.y); 
    for (ChatMessage chatMessage : messages) { 
      chatMessage.update();
    }   
  }
  
  public void sendMessage(String msg) {
    client.sendMessageNew(msg);
    receiveMessage(msg, true);
  }
  
  public void receiveMessage(String msg, boolean fromMe) {
  for (ChatMessage chatMessage : messages) { 
      chatMessage.addMargin();
    }
    
    //Change message position depending on who send it
    PVector newPos;
    if (fromMe) {
      newPos = new PVector(margin, size.y + margin);
    } else {
      newPos = new PVector(size.x - margin, size.y + margin);
    }
    
    messages.add(new ChatMessage(newPos, msg, fromMe));
  }
  
  private void connectToServer (String username, String room) {
    try {
      socket = new Socket("localhost",8000);
      client = new Client(socket, username, room);
      client.listenForMessage();
      print("Connected to server as: " + username + " in room: " + room);
    } catch (IOException e) {
  
    }
  }
}
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
      text("[" + username + "]", width/2, height/1.2f);
    }
  }
  
  public Chat getChat () {
    return chat;
  }
  
}





public class Client {
    private Socket socket;
    private BufferedReader bufferedReader;
    private BufferedWriter bufferedWriter;
    private String username;
    private String chatRoom;

    public Client(Socket socket, String Username, String ChatRoom){
        try{
            this.socket = socket;
            this.bufferedWriter = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
            this.bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            this.username = Username;
            this.chatRoom = ChatRoom;

        } catch (IOException e) {
            closeEverything(socket, bufferedWriter, bufferedReader);
        }
    }
    public void sendMessage(){
        try{
            bufferedWriter.write(username);
            bufferedWriter.newLine();

            bufferedWriter.write(chatRoom);
            bufferedWriter.newLine();
            bufferedWriter.flush();

            Scanner scanner = new Scanner(System.in);
            while(socket.isConnected()){
                String messageToSend = scanner.nextLine();
                bufferedWriter.write(username + ": " + messageToSend);
                bufferedWriter.newLine();
                bufferedWriter.flush();

            }
        } catch (IOException e) {
            closeEverything(socket, bufferedWriter, bufferedReader);
        }
    }

    public void sendMessageNew(String msg) {
        print(msg + " sent");
        try {
            bufferedWriter.write(username + "\n");
            bufferedWriter.write(chatRoom + "\n");
            
            if (socket.isConnected()) {
              
                bufferedWriter.write(msg + " - " + username);
                bufferedWriter.newLine();
                bufferedWriter.flush();
                
            }
        } catch (IOException e) {
            closeEverything(socket, bufferedWriter, bufferedReader);
        }
    }

    public void listenForMessage() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                String messageFromGroupChat;
                while (socket.isConnected()){
                    println("Is Connected");
                    try {
                        messageFromGroupChat = bufferedReader.readLine();
                        println(messageFromGroupChat);
                        //System.out.println(messageFromGroupChat);
                        if(pages[2] instanceof ChatPage) ((ChatPage)pages[2]).getChat().receiveMessage(messageFromGroupChat, false);
                        
                    } catch (IOException e) {
                        closeEverything(socket, bufferedWriter, bufferedReader);
                    }
                }
            }
        }).start();
    }

    public  void closeEverything(Socket socket, BufferedWriter bufferedWriter, BufferedReader bufferedReader){
        try {
            if(bufferedWriter != null){ //here we check if bufferedReader is not equal to null in order to avoid null-pointer-exception.
                bufferedReader.close();
            }
            if(bufferedReader != null){ //here we check if bufferedWriter is not equal to null in order to avoid null-pointer-exception.
                bufferedWriter.close();
            }

            if(socket != null){ //here we check if socket is not equal to null in order to avoid null-pointer-exception.
                socket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
public class FrontPage extends Page {
  public FrontPage() {
    super("USERNAME");
    
    textFields.add(new TextField(new PVector(125, 225), new PVector(250, 50), "Enter Username", "nextPage", Type.Username));
  }
}
class Interactable { 
  public PVector position, size;
  public String text, methodToRun;
  public int normalColour = 0xffF0F0F0; 
  public int hoverColor = 0xffD3D3D3; 
  public int textColor = 0xffFF6767;
  public int textSize = 18;
  
  public boolean isHovering;
  
  public void update() {
    //Visual elements of interactable prompts
    textAlign(CENTER, CENTER);
    fill(overBox()? hoverColor : normalColour);
    rect(position.x, position.y, size.x, size.y);
    
    fill(textColor);
    textSize(textSize);
    text(text, position.x + size.x/2, position.y + size.y/2);
  }
  
  public void click() {
    //Runs method if the interactable prompt is pressed
    if (overBox()) {
      method(methodToRun);
    }
  }

  //Boolean for checking if those is over the specified box
  public boolean overBox() {
    return isHovering = mouseX > position.x & mouseX < position.x + size.x 
    & mouseY > position.y & mouseY < position.y + size.y;
  }
}
public class LobbyPage extends Page {
    public LobbyPage() {
    super("SELECT LOBBY");
    buttons.add(new Button(new PVector(50, 250), new PVector(350, 50), "Lobby (1)", "setRoom1"));
    buttons.add(new Button(new PVector(50, 300), new PVector(350, 50), "Lobby (2)", "setRoom2"));
    buttons.add(new Button(new PVector(50, 350), new PVector(350, 50), "Lobby (3)", "setRoom3"));
    buttons.add(new Button(new PVector(50, 400), new PVector(350, 50), "Lobby (4)", "setRoom4"));
  }
}
public class Page {
  public int bckColour = color(200,200,200);
  public int textColour = color(255, 255, 255);
  public String title;
  public boolean active = false;
  
  public ArrayList<Chat> chats = new ArrayList<Chat>();
  public ArrayList<Button> buttons = new ArrayList<Button>();
  public ArrayList<TextField> textFields = new ArrayList<TextField>();
  
  public Page (String title) {
    this.title = title;
  }
  
  public void setActive() {
    active = true;
  }
  
  public void setActive(boolean value) {
    active = value;
  }
  
  public void keyPress() {
    if (active) {
      for (TextField textField : textFields) { 
        textField.keypressed(key, keyCode);
        textField.keyPress();
      }
    }
    
  }
  
  public void click() {
    if (active) {
      for (Button button : buttons) { 
        button.click();
      }
      for (TextField textField : textFields) { 
        textField.click();
      }
    }
  }
  
  public void update() {
    if (active) {
      background(bckColour);
      fill(color(textColour));
      textAlign(LEFT);
      text(title, 10, 25);
    
      for (Chat chat : chats) { 
        chat.update();
      }     
      for (Button button : buttons) { 
        button.update();
      }
      for (TextField textField : textFields) { 
        textField.update();
      }
    }
  }
}  
public enum Type {
  Username,
  Chat,
  IP
}

class TextField extends Interactable { 
  
  int textLength = 0;
  int textOffSet = 20;
  boolean selected = false;
  boolean firstSelect = true;
  Type type;
  
  int foreGround = color(0, 0, 0);
  
  //Constructor
  TextField(PVector position, PVector size, String text, String methodToRun, Type type) {
    this.position = position; 
    this.size = size; 
    this.text = text;
    this.methodToRun = methodToRun;
    this.type = type;
  }
  
  //Overides Interactable update method
  public void update() {
    // DRAWING THE TEXTFIELD
    if (selected) {
       fill(normalColour);
    } else {
       fill(hoverColor);
    }
    rect(position.x, position.y, size.x, size.y);
      
    // DRAWING THE TEXT ITSELF
    textAlign(LEFT, CENTER);
    fill(textColor);
    textSize(textSize);
    text(text, position.x + size.x/textOffSet, position.y + size.y/2);
  }
  
  //Overides Interactable click method
  public void click() {
    pressed();
    
    if (selected && firstSelect) {
       cleanText();
       firstSelect = false;
    }
    
  }
  
  public void keyPress() {
    if (selected && key == ENTER) {
      method(methodToRun);
    }
  }
  
   public boolean keypressed(char KEY, int KEYCODE) {
     // CHECKS IF TEXTFIELD IS SELECTED
      if (selected) {
         // CHECKS IF BACKSPACE IS PRESSED
         if (KEYCODE == (int)BACKSPACE) {
             backSpace();
         } else if (KEYCODE == 32) {
           // CHECKS IF SPACE IS PRESSED
             addText(' ');
           // CHECKS IF ENTER IS PRESSED
         } else if (KEYCODE == (int)ENTER) {
             println(text);
             switch(type) {
               case Username:
                 username = text;
                 break;
               case Chat:
                 if(pages[2] instanceof ChatPage) ((ChatPage)pages[2]).getChat().sendMessage(text);
                 break;
             }
             cleanText();
             return true;
         } else {
             // CHECK IF THE KEY IS A LETTER OR A NUMBER
             boolean isKeyCapitalLetter = (KEY >= 'A' && KEY <= 'Z');
             boolean isKeySmallLetter = (KEY >= 'a' && KEY <= 'z');
             boolean isKeyNumber = (KEY >= '0' && KEY <= '9');
      
             if (isKeyCapitalLetter || isKeySmallLetter || isKeyNumber) {
               addText(KEY);
            }
         }
      }
      return false;
   }
   
   private void addText(char letter) {
      // IF THE TEXT WIDTH IS IN BOUNDARIES OF THE TEXTBOX
      if (textWidth(text + letter) < size.x - (size.x / textOffSet*2)) {
         text += letter;
         textLength++;
      }
   }
   
   private void backSpace() {
      if (textLength - 1 >= 0) {
         text = text.substring(0, textLength - 1);
         textLength--;
      }
   }
   
   public void pressed() {
      if (overBox()) {
         selected = true;
      } else {
         selected = false;
      }
   }
   
   public void cleanText() {
     textLength = 0;
     text = "";
   }
}
  public void settings() {  size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FinalClient" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
