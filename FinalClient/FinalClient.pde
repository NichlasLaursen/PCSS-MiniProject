import java.util.Random;

Page[] pages = new Page[3];
String username, room;
int currPage = 0;

public void setup () {
  size(500, 500);
  
  setInitialData();
  
  pages[0] = new FrontPage();
  pages[1] = new LobbyPage();
  pages[2] = new ChatPage();
  
  pages[0].setActive();
}

public void draw () {
  updatePages();
}

void mousePressed () {
  for (int i = 0; i < pages.length; i++) {
     pages[i].click();
  }
}

void keyPressed() {   
  for (int i = 0; i < pages.length; i++) {
     pages[i].keyPress();
  }
  
  if (key == ENTER) {
    //currPage++;
    //setPage(currPage);
  }
}

public void setInitialData() {
  Random r = new Random();
  username = "Per" + r.nextInt(1000);
  room = "Room1";
}

public void updatePages() {
  for (int i = 0; i < pages.length; i++) {
    pages[i].update();
  }
}

public void Hej() {

}
public void nextPage() {
    currPage++;
    setPage(currPage);
}

public void setPage(int index) {
  if (index < pages.length) {
    for (int i = 0; i < 0; i++) {
      pages[i].setActive(false);
    }
    pages[index].setActive();
    redraw();
  } else {
    print ("Index out of bounds");
  }
}