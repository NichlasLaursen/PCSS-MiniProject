//Main navigation buttons
Button chat, profile, inbox;

//Buttons to chat with dudes
Button chat0, chat1, chat2, chat3;

//Background color
int backCl = #818181;

int page;

int chatno;

void setup(){
 size(1000,700);
 surface.setResizable(true);
 
 textAlign(CENTER, CENTER);
 
 stroke(0);
 strokeWeight(1.5);
 
 //Main navigation button constructing
 chat = new Button ("Available chats", 0, 0);
 profile = new Button("Profile", 0, 0 + Button.H);
 inbox = new Button("Inbox", 0, 0 + (Button.H*2));
 
 //Constructing buttons to chat with dudes
 chat1 = new Button ("Chad", 0, height/2);
 chat2 = new Button ("Chris", 0, (height/2) + Button.H);
 chat3 = new Button ("Robert", 0, (height/2) + (Button.H*2));
}

void draw(){
 background(backCl);
  
 chat.display(); 
 profile.display();
 inbox.display();
 
 method("page"+page);
 
 method("chat"+chatno);
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
  if (chat.isHovering) page = 0;
  if (profile.isHovering) page = 1;
  if (inbox.isHovering) page = 2;
  
  // Chat page navigation
  if (chat1.isHovering) chatno = 1;
  if (chat2.isHovering) chatno = 2;
  if (chat3.isHovering) chatno = 3;
}
