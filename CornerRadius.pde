
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

PVector p1Anchor;
PVector p2Anchor;
PVector p1Control;
PVector p2Control;
PVector apex;
PVector leftApex;
PVector rightApex;

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
float xPos, yPos;  //x, y座標

float startDeg[];
int count = 6;


boolean showLines = false;

void setup() {

 size(500, 500);
 defaultX = new float[length];
 defaultY = new float[length];
 for (int i = 0; i < length; i++) {
   defaultX[i] = x[i];
   defaultY[i] = y[i];
 }
 
 
  smooth();
  A = 5.0;    //振幅を設定
  B = 3.0;
  w = 1.0;    //角周波数を設定
  w2 = 0.5;    //角周波数を設定
  p = 0.0;    //初期位相を設定
  t2 = 0.0;    //経過時間を初期化
  time = 0.0;
  
  startDeg = new float[6];
  for (int i = 0; i < 6; i++) {
    startDeg[i] = random(180);
  }
  
  p1Anchor = new PVector();
  p2Anchor = new PVector();
  p1Control = new PVector();
  p2Control = new PVector();
  apex = new PVector();
  leftApex = new PVector();
  rightApex = new PVector();
}

void draw() {
 update();
 background(255);
 pushMatrix();
 //translate(width / 2 - 100, height / 2 - 92);

 if (showLines) {
   noFill();
   stroke(0, 0, 0);
   beginShape();
   for (int i = 0; i < 6; i++) {
     vertex(x[i], y[i]);
   }
   endShape(CLOSE);   
 }

 int count = 6;
 beginShape();

 for (int i = 0; i < count; i++) {
   next(i, false);
   noFill();
   fill(255, 0, 0);
   // draw bezier
   //noStroke();
   stroke(0, 0, 255);
   noFill();
   
   if (showLines) {
     pushStyle();
     fill(0);
     ellipse(p1Anchor.x, p1Anchor.y, 5, 5);
     line(p1Anchor.x, p1Anchor.y, p2Anchor.x, p2Anchor.y);
     //ellipse(p2AnchorX, p2AnchorY, 5, 5);
     popStyle();        
   }
   
   if (i == 0) {
     vertex(p1Anchor.x, p1Anchor.y);
   } else {
     bezierVertex( p1Control.x, p1Control.y, p2Control.x, p2Control.y, p2Anchor.x, p2Anchor.y );
     //bezierVertex( 450, 50, 75, 350, 50, 50 );
     if (i == count - 1) {
       next(i, true);       
       bezierVertex( p1Control.x, p1Control.y, p2Control.x, p2Control.y, p2Anchor.x, p2Anchor.y );
       
       if (showLines) {
         pushStyle();
         fill(0);
         ellipse(p1Anchor.x, p1Anchor.y, 5, 5);
         line(p1Anchor.x, p1Anchor.y, p2Anchor.x, p2Anchor.y);
         //ellipse(p2AnchorX, p2AnchorY, 5, 5);
         popStyle();                
       }
     }
   }   
 }
   endShape(CLOSE);

 popMatrix(); 
}

void next(int i, boolean isLast) {
   
   if (isLast) {
     leftApex.x = x[count - 1];
     leftApex.y = y[count - 1]; 
     
     apex.x = x[0];
     apex.y = y[0];     
     
     rightApex.x = x[1];     
     rightApex.y = y[1];
   } else {
     leftApex.x = i == 0 ? x[i] : x[i - 1];
     leftApex.y = i == 0 ? y[i] : y[i - 1];
     apex.x = i == 0 ? x[i + 1] : x[i];
     apex.y = i == 0 ? y[i + 1] : y[i];
     rightApex.x = i >= count - 1 ? x[0] : x[i + 1];
     rightApex.y = i >= count - 1 ? y[0] : y[i + 1];          
   }
   
   p1Anchor.x = (leftApex.x + apex.x) / 2;
   p1Anchor.y = (leftApex.y + apex.y) / 2;
   
   p2Anchor.x = (apex.x + rightApex.x) / 2;   
   p2Anchor.y = (apex.y + rightApex.y) / 2;
   
   p1Control.x = (apex.x + p1Anchor.x) / 2;   
   p1Control.y = (apex.y + p1Anchor.y) / 2;
   
   p2Control.x = (apex.x + p2Anchor.x) / 2;   
   p2Control.y = (apex.y + p2Anchor.y) / 2;
}

void update() {
  for (int i = 0; i < 6; i++) {
     diffY = A * sin(w * radians(t2) + radians(startDeg[i]));
     diffY += B * sin(w2 * radians(t2) + radians(startDeg[i]));
    yPos = A * sin(w * radians(t2) + radians(startDeg[i]));    //processingのy座標は数学の座標と反対のため、-にする
    //yPos += B * sin(w2 * radians(t2) + radians(startDeg[i]));
    xPos = 2.5 * cos(radians(time + t2) + radians(startDeg[i]));
    //xPos += 4 * cos(radians(time + t2) + radians(startDeg[i])); 
     
    x[i] = defaultX[i] + xPos;       
    y[i] = defaultY[i] + yPos;
     //x[i] = defaultX[i] + 2 * cos(radians(time + startDeg[i]));
     ////y[i] = defaultY[i] + diffY;
     //y[i] = defaultY[i] + diffY;
  }
  time += random(5) - 2;
  t2 += 5 * sin(radians(time));
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
 } else if (key == 'l') {
   showLines = !showLines;
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