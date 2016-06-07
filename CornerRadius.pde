
float scale = 3;
int length = 6;
float x[] = {0.0, 50.141 * scale, 100.0 * scale, 100.0 * scale, 50.141 * scale, 23.622 * scale};
float y[] = {21.165 * scale, 7.66 * scale, 18.554 * scale, 75.846 * scale, 92.34 * scale, 75.846 * scale};
float defaultX[];
float defaultY[];
int keyType = 0;
float leftX = 0;
float leftY = 0;
float apexX = 0;
float apexY = 0;
float rightX = 0;
float rightY = 0;
float p1AnchorX = 0.0;
float p1AnchorY = 0.0;
float p2AnchorX = 0.0;
float p2AnchorY = 0.0;
float p1ControlX = 0.0;
float p1ControlY = 0.0;
float p2ControlX = 0.0;
float p2ControlY = 0.0;

// animation
float diffY; 
float A;  
float B;  
float w;  
float w2; 
float p;  
float t1; 
float t2; 
float speed = 3.0;
float time;

float startDeg[];

void setup() {

 size(500, 500);
 defaultX = new float[length];
 defaultY = new float[length];
 for (int i = 0; i < length; i++) {
   defaultX[i] = x[i];
   defaultY[i] = y[i];
 }
 
 
  smooth();
  A = 15.0;    //振幅を設定
  B = 10.0;
  w = 10.0;    //角周波数を設定
  w2 = 40.0;    //角周波数を設定
  p = 0.0;    //初期位相を設定
  t2 = 0.0;    //経過時間を初期化
  time = 0.0;
  
  startDeg = new float[6];
  for (int i = 0; i < 6; i++) {
    startDeg[i] = i * 30;
  }
}

void draw() {
 update();
 background(255);
 pushMatrix();
 translate(width / 2 - 100, height / 2 - 92);

 noFill();
 stroke(0, 0, 0);
 beginShape();
 for (int i = 0; i < 6; i++) {
   vertex(x[i], y[i]);
 }
 endShape(CLOSE);

 int count = 6;
 beginShape();

 for (int i = 0; i < count; i++) {
   leftX = i == 0 ? x[i] : x[i - 1];
   leftY = i == 0 ? y[i] : y[i - 1];
   apexX = i == 0 ? x[i + 1] : x[i];
   apexY = i == 0 ? y[i + 1] : y[i];
   rightX = i >= count - 1 ? x[0] : x[i + 1];
   rightY = i >= count - 1 ? y[0] : y[i + 1];
           
   p1AnchorX = (leftX + apexX) / 2;
   p1AnchorY = (leftY + apexY) / 2;
   p2AnchorX = (apexX + rightX) / 2;
   p2AnchorY = (apexY + rightY) / 2;
   p1ControlX = (apexX + p1AnchorX) / 2;
   p1ControlY = (apexY + p1AnchorY) / 2;
   p2ControlX = (apexX + p2AnchorX) / 2;
   p2ControlY = (apexY + p2AnchorY) / 2;

   noFill();
   // draw control point
   //stroke(0, 255, 0);
   //line(p1AnchorX, p1AnchorY, p1ControlX, p1ControlY);
   //line(p2AnchorX, p2AnchorY, p2ControlX, p2ControlY);

   fill(255, 0, 0);
   // draw bezier
   //noStroke();
   stroke(0, 0, 255);
   noFill();
   
   pushStyle();
   fill(0);
   ellipse(p1AnchorX, p1AnchorY, 5, 5);
   line(p1AnchorX, p1AnchorY, p2AnchorX, p2AnchorY);
   //ellipse(p2AnchorX, p2AnchorY, 5, 5);
   popStyle();   
   
   if (i == 0) {
     vertex(p1AnchorX, p1AnchorY);
   } else {
     bezierVertex( p1ControlX, p1ControlY, p2ControlX, p2ControlY, p2AnchorX, p2AnchorY );
     //bezierVertex( 450, 50, 75, 350, 50, 50 );
     if (i == count - 1) {
       leftX = x[count - 1];
       leftY = y[count - 1];
       apexX = x[0];
       apexY = y[0];
       rightX = x[1];
       rightY = y[1];
       diffY = -A * sin(w*radians(t2) - p);    //processingのy座標は数学の座標と反対のため、-にする
       diffY += B * sin(w2 * radians(t2) - p);
       
       p1AnchorX = (leftX + apexX) / 2;
       p1AnchorY = (leftY + apexY) / 2;
       p2AnchorX = (apexX + rightX) / 2;
       p2AnchorY = (apexY + rightY) / 2;
       p1ControlX = (apexX + p1AnchorX) / 2;
       p1ControlY = (apexY + p1AnchorY) / 2;
       p2ControlX = (apexX + p2AnchorX) / 2;
       p2ControlY = (apexY + p2AnchorY) / 2;
       bezierVertex( p1ControlX, p1ControlY, p2ControlX, p2ControlY, p2AnchorX, p2AnchorY );
       
       pushStyle();
       fill(0);
       ellipse(p1AnchorX, p1AnchorY, 5, 5);
       line(p1AnchorX, p1AnchorY, p2AnchorX, p2AnchorY);
       //ellipse(p2AnchorX, p2AnchorY, 5, 5);
       popStyle();       
     }
   }   
 }
   endShape(CLOSE);

 popMatrix(); 
}

void update() {
  for (int i = 0; i < 6; i++) {
     diffY = -A * sin(w * radians(t2) + radians(startDeg[i]));
     diffY += B * sin(w2 * radians(t2) + radians(startDeg[i]));
     x[i] = defaultX[i] + 10 * sin(radians(time + startDeg[i]));
     //y[i] = defaultY[i] + diffY;
     y[i] = defaultY[i] + diffY;
  }
  time += speed;
  t2 = 5 * sin(radians(time));
}

void keyPressed() {
 if (key == '1') {
   keyType = 1;
 } else if (key == '2') {
   keyType = 2;
 } else if (key == '3') {
   keyType = 3;
 } else if (key == '4') {
 keyType = 4;
 } else if (key == '5') {
   keyType = 5;
 } else if (key == '6') {
   keyType = 6;
 } else if (key == 'c') {
   keyType = 0;
   print("\nkeytype = 0");
   x = defaultX;
   y = defaultY;

 }
}

void mouseMoved() {
 float mx = mouseX - width / 2;
 float my = mouseY - height /2;
 if (keyType == 1) {
    x[0] = defaultX[0] + mx;
 } else if (keyType == 2) {
    y[1] = defaultY[1] + my;
 } else if (keyType == 3) {
    x[2] = defaultX[2] + mx;
 } else if (keyType == 4) {
    x[3] = defaultX[3] + mx;
 } else if (keyType == 5) {
    y[4] = defaultY[4] + my;
 } else if (keyType == 6) {
    x[5] = defaultX[5] + mx;
 }
}