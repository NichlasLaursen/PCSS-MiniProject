class TextField extends Interactable { 
  
  int textLength = 0;
  int textOffSet = 20;
  boolean selected = false;
  boolean firstSelect = true;
  
  color foreGround = color(0, 0, 0);
  //color Border = color(30, 30, 30);
  //int BorderWeight = 1;
  
  TextField(PVector position, PVector size, String text, String methodToRun) {
    this.position = position; 
    this.size = size; 
    this.text = text;
    this.methodToRun = methodToRun;
  }
  
  void update() {
    
    // DRAWING THE BACKGROUND
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
      if (selected) {
         if (KEYCODE == (int)BACKSPACE) {
             backSpace();
         } else if (KEYCODE == 32) {
             // SPACE
             addText(' ');
         } else if (KEYCODE == (int)ENTER) {
             println(text);
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
     text = "";
   }
   
   void commit(String currentText) {
     
   }
}
