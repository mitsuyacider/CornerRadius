float x[] = {0.0, 50.141 * 2, 100.0 * 2, 100.0 * 2, 50.141 * 2, 23.622 * 2};    
float y[] = {21.165 * 2, 7.66 * 2, 18.554 * 2, 75.846 * 2, 92.34 * 2, 75.846 * 2};
float defaultX[];    
float defaultY[];
int keyType = 0;

void setup() {
  
  size(500, 500);
  defaultX = x.clone();
  defaultY = y.clone();
}

void draw() {
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
    
    float leftX = 0;
    float leftY = 0;
    float apexX = 0;
    float apexY = 0;
    float rightX = 0;
    float rightY = 0;
    if (i >= count - 2) {
      if( i == count - 1) {
        leftX = x[i];
        leftY = y[i];
        apexX = x[0];
        apexY = y[0];
        rightX = x[1];
        rightY = y[1];              
      } else {
        leftX = x[i];
        leftY = y[i];
        apexX = x[i + 1];
        apexY = y[i + 1];
        rightX = x[0];
        rightY = y[0];                      
      }
    } else {
      if (i == 0) {
        
      } else {
        leftX = x[i - 1];
        leftY = y[i - 1];
        apexX = x[i];
        apexY = y[i];
        rightX = x[i + 1];
        rightY = y[i + 1
        ];        
      }
    }
    
    float p1AnchorX = (leftX + apexX) / 2;
    float p1AnchorY = (leftY + apexY) / 2;    
    float p2AnchorX = (apexX + rightX) / 2;
    float p2AnchorY = (apexY + rightY) / 2;    
    float p1ControlX = (apexX + p1AnchorX) / 2;
    float p1ControlY = (apexY + p1AnchorY) / 2;
    float p2ControlX = (apexX + p2AnchorX) / 2;
    float p2ControlY = (apexY + p2AnchorY) / 2;
    
    
    noFill();

    // draw control point
    stroke(0, 255, 0);  
    line(p1AnchorX, p1AnchorY, p1ControlX, p1ControlY);
    line(p2AnchorX, p2AnchorY, p2ControlX, p2ControlY);
  
    fill(255, 0, 0);
    // draw bezier
    noStroke();
    if (i == 0) {
      vertex(x[0], y[0]);
    } else {
      bezierVertex( 50, 450, 150, 450, 450, 450 );
      bezierVertex( 450, 50, 75, 350, 50, 50 );

    }

    //bezier(p1AnchorX, p1AnchorY,  p1ControlX, p1ControlY,  p2ControlX, p2ControlY, p2AnchorX, p2AnchorY);    
  }
    endShape();
  
  popMatrix();
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