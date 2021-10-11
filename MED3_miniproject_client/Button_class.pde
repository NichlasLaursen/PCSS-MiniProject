class Button {
  static final int W = 200, H = 80, TXTSZ = 18;
  static final color BTNC = #00A0A0, HOVC = #00FFFF, TXTC = 0;
 
  final String label;
  final int x, y, xW, yH;
 
  boolean isHovering;
 
  Button(String txt, int xx, int yy) {
    label = txt;
 
    x = xx;
    y = yy;
 
    xW = xx + W;
    yH = yy + H;
  }
 
  void display() {
    fill(isHovering? HOVC : BTNC);
    rect(x, y, W, H);
 
    fill(TXTC);
    textSize(TXTSZ);
    text(label, x + W/5, y + H/2);
  }
 
  boolean isInside() {
    return isHovering = mouseX > x & mouseX < xW & mouseY > y & mouseY < yH;
  }
}
