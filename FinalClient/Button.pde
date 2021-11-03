class Button extends Interactable { 
  
  Button(PVector position, PVector size, String text, String methodToRun) {
    this.position = position; 
    this.size = size; 
    this.text = text;
    this.methodToRun = methodToRun;
  }

  //Overides Interactable click method
  void click() {
    if (overBox()) {
      method(methodToRun);
    }
  }
}
