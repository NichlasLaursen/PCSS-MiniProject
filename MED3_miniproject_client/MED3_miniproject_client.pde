Button home, profile, inbox;
int backCl = #818181;

int page;

void setup(){
 size(1000,700);
 surface.setResizable(true);
 
 textAlign(CENTER, CENTER);
 
 stroke(0);
 strokeWeight(1.5);
 
 home = new Button ("Home", 0, 0);
 profile = new Button("Profile", 0, 0 + Button.H);
 inbox = new Button("Inbox", 0, 0 + (Button.H*2));
}

void draw(){
 background(backCl);
  
 home.display(); 
 profile.display();
 inbox.display();
 
 method("page"+page);
}

void mouseMoved(){
  home.isInside();
  profile.isInside();
  inbox.isInside();
}

void mousePressed(){
  if (home.isHovering) page = 0;
  if (profile.isHovering) page = 1;
  if (inbox.isHovering) page = 2;
  }
