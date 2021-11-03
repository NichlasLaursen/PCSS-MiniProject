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
  
  color foreGround = color(0, 0, 0);
  //color Border = color(30, 30, 30);
  //int BorderWeight = 1;
  
  //Constructor
  TextField(PVector position, PVector size, String text, String methodToRun, Type type) {
    this.position = position; 
    this.size = size; 
    this.text = text;
    this.methodToRun = methodToRun;
    this.type = type;
  }
  
  //Overides Interactable update method
  void update() {
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
    
    // CHECKS IF TEXTFIELD IS SELECTED AND ENTER IS PRESSED
  }
  
  //Overides Interactable click method
  void click() {
    pressed();
    
    if (selected && firstSelect) {
       cleanText();
       firstSelect = false;
    }
    
  }
  
  void keyPress() {
    if (selected && key == ENTER) {
      method(methodToRun);
      println("TextField");
    }
  }
  
  
   boolean keypressed(char KEY, int KEYCODE) {
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
                 if(pages[2] instanceof ChatPage) ((ChatPage)pages[2]).getChat().receiveMessage(text, false);
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
   
   void pressed() {
      if (overBox()) {
         selected = true;
      } else {
         selected = false;
      }
   }
   
   void cleanText() {
     textLength = 0;
     text = "";
   }
   
   void commit(String currentText) {
     
   }
}
