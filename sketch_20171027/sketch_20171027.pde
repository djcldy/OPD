
PShape shape;

float rY = 0.001; 
float k = 1;
float r = 1; 

PImage a, b; 

int dimX = 4000;
int dimY = 4000;
int dimZ = 4000;  
  float maxDistance = sqrt(dimX*dimX + dimY*dimY + dimZ*dimZ);  
void setup() { 

  size(800, 800, P3D);
  background(255);

  a = loadImage("textureA.jpg");
  b = loadImage("textureB.jpg");

  a.resize(dimX, dimY);
  b.resize(dimX, dimY); 


  //PImage a = loadImage(null);
  //PImage b = loadImage(null);

  println("generate point cloud"); 

  //shape = GenTextureCloud(a, b);
}



void draw() {
  //background(random(0,255));
  background(255); 

  pushMatrix();


  translate(width/2, height/2, 0);
  scale(.1);
  rotateY(rY); 
  rotateX(rY); 
  rotateZ(rY); 

strokeWeight(10);

  for (int i =0; i < 1000000; i++) {
    float x =int(random(-dimX/2, dimX/2));
    float y =int(random(-dimY/2, dimY/2));
    float z =int(random(-dimZ/2, dimZ/2)); 
    
    samplePoint(x, y, z);
  }

  popMatrix();

  rY += 0.005;


  if (random(0,1) > 0.99){saveFrame("output -####.jpg");};
  //delay(200);
}

void samplePoint(float x, float y, float z) { 

  color c = getColorTex(x, y, z);  
  stroke(c);
  point(x, y, z);
} 

color getColor(float x, float y, float z) {

  float tRed = (x + dimX/2)/dimX*255;
  float tBlue =(y + dimY/2)/dimY*255; 
  float tGreen = (z + dimZ/2)/dimZ*255;

//  if (random(0, 1) > 0.9999) { 
//    println(tRed + "," + tBlue + "," + tGreen);
//  }

  return color(int(tRed), int(tBlue), int(tGreen), 200);
} 

color getColorTex(float x, float y, float z) {

  
  color c1 = a.get(int(x + dimX/2),int(y+dimY/2)); 
  color c2 = b.get(int(x + dimX/2), int(y+dimY/2));
  float t = (z+dimZ/2)/float(dimZ);  

  float r1 = red(c1); 
  float r2 = red(c2); 
  float g1 = green(c1);
  float g2 = green(c2); 
  float b1 = blue(c1);
  float b2 = blue(c2);  

  float r = r1*t + r2*(1-t); 
  float g = g1*t + g2*(1-t);
  float bl = b1*t + b2*(1-t); 
  
  float distance = sqrt(x*x + y*y + z*z); 
  float alpha = (distance/maxDistance)*255; 
  
  //if (random(0,1) > 0.9999){println("alpha" + alpha);}

  return color(int(r), int(g), int(bl), alpha);
}


PShape GenTextureCloud(PImage _a, PImage _b) {


  PImage a = _a.get();  
  PImage b = _b.get(); 

  a.resize(dimX, dimY);
  b.resize(dimX, dimY); 

  PShape boxCloud = createShape();
  boxCloud.beginShape(POINTS);
  boxCloud.strokeWeight(5);




  for (int x = 0; x < dimX; x++) { 
    for (int y = 0; y < dimY; y++) { 
      for (int z = 0; z < dimZ; z ++) {  

        color c1 = a.get(x, y); 
        color c2 = b.get(x, y);
        float t = float(z)/float(dimZ);  

        float r1 = red(c1); 
        float r2 = red(c2); 
        float g1 = green(c1);
        float g2 = green(c2); 
        float b1 = blue(c1);
        float b2 = blue(c2);  

        float r = r1*t + r2*(1-t); 
        float g = g1*t + g2*(1-t);
        float bl = b1*t + b2*(1-t); 

        //boxCloud.stroke(r,g,b); 
        boxCloud.stroke(r, g, bl, 200);
        boxCloud.vertex(x-dimX/2, y-dimY/2, z-dimZ/2);
      }
    }
  }
  boxCloud.endShape();
  return boxCloud;
}




PShape GenPointCloud() {

  PShape boxCloud = createShape();
  boxCloud.beginShape(POINTS);
  boxCloud.strokeWeight(3);


  for (float x = -10; x < 10; x++) { 
    for (float y = -10; y < 10; y++) { 
      for (float z = -10; z < 10; z ++) {  

        float r = (x+10)/20*255;
        float g = (y+10)/20*255;        
        float b = (z+10)/20*255;

        println(r + "," + g + "," + b);

        //boxCloud.stroke(r,g,b); 
        boxCloud.stroke(r, g, b, 150);
        boxCloud.vertex(x, y, z);
      }
    }
  }
  boxCloud.endShape();
  return boxCloud;
}



//PShape getPointCloud(){

//  PShape boxCloud = createShape();
//  boxCloud.beginShape(POINTS);
//  boxCloud.stroke(34,155,215,50);

//  for (int i = 0; i < 500; i ++ ){

//  boxCloud.vertex(random(-10,10), random(-10,10),  random(-10,10));

//  }



//  boxCloud.endShape();

//  return boxCloud;

//}