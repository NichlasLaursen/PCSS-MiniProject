import processing.net.*;

Client myClient;

int port = 10001;

//Main navigation buttons
Button chat, profile, inbox;

//Buttons to chat with dudes
Button chat0, chat1, chat2, chat3;

//Background color
int backCl = #818181;

boolean send = false;
String msg = "";
float msgH = height/4;
int msgN = 0;

int page;

int chatno;

ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>();
ArrayList<String> msgs = new ArrayList<String>();

void setup(){
 size(1000,700);
 surface.setResizable(true);
 
 myClient = new Client(this, "localhost", port);
 
 stroke(0);
 strokeWeight(1.5);
 
 
 //Main navigation button constructing
 chat = new Button ("Available chats", 0, 0);
 profile = new Button("Profile", 0, 0 + Button.H);
 inbox = new Button("Inbox", 0, 0 + (Button.H*2));
 
 //Constructing buttons to chat with dudes
 chat1 = new Button ("Chad", 0, height-(Button.H*3));
 chat2 = new Button ("Chris", 0, height-(Button.H*2));
 chat3 = new Button ("Robert", 0, height-Button.H);
 
 textBoxLayout();
 
}

void draw(){
 background(backCl);
  
 chat.display(); 
 profile.display();
 inbox.display();
 
 method("page"+page);
 
 method("chat"+chatno);
 
 if (chatno == 1) {
   TEXTBOX t1 = textboxes.get(0);
   t1.DRAW();
 }
 
 if (chatno == 2) {
   TEXTBOX t2 = textboxes.get(1);
   t2.DRAW();
 }
 
 if (chatno == 3) {
   TEXTBOX t3 = textboxes.get(2);
   t3.DRAW();
 }
 
 if (send) {
   for ( int j = 0; j<msgs.size(); j++){
   text(msgs.get(j), width/2 + (Button.W/2), msgH);
   if (j < msgs.size()){
       msgH += 10;
     println("j: " + j);
   }
  } 
 }
 println("Number of messages: " + msgs.size());
   println("message position height: " + msgH);
 }




void textBoxLayout(){
  TEXTBOX chadrec = new TEXTBOX((0+Button.W)+3, height-80, (width-Button.W)-5, 35);
  textboxes.add(chadrec);
  
  TEXTBOX chrisrec = new TEXTBOX((0+Button.W)+3, height-60, (width-Button.W)-5, 35);
  textboxes.add(chrisrec);
  
  TEXTBOX robertrec = new TEXTBOX((0+Button.W)+3, height-40, (width-Button.W)-5, 35);
  textboxes.add(robertrec);
}
  

void mouseMoved(){
  
  //Button highlight for main buttons
  chat.isInside();
  profile.isInside();
  inbox.isInside();
  
  //Button highlight for chat buttons
  chat1.isInside();
  chat2.isInside();
  chat3.isInside();
}

void mousePressed(){
  
  // Main page navigation
  if (chat.isHovering) {
       page = 0;
       chatno = 0;
  }
  if (profile.isHovering){
       page = 1;
       chatno = 0;
  }
  if (inbox.isHovering) {
       page = 2;
       chatno = 0;
  }
  
  // Chat page navigation
  if (chat1.isHovering) chatno = 1;
  if (chat2.isHovering) chatno = 2;
  if (chat3.isHovering) chatno = 3;
  
  for (TEXTBOX t: textboxes) {
    t.PRESSED (mouseX, mouseY);
  }
}

void keyPressed() {
  for (TEXTBOX t : textboxes) {
    if (t.KEYPRESSED(key, keyCode)) {
      send = true;
      msg = textboxes.get(0).Text;
      msgs.add(msg);
  }
}
}
