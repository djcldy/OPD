PShape shape;

float rY = 0.001; 
float k = 1;
float r = 1; 
void setup(){ 

  size(800,800,P3D);
  background(255);
  
  //PImage a = loadImage("textureA.jpg");
  //PImage b = loadImage("textureB.jpg");
    //PImage a = loadImage(null);
  //PImage b = loadImage(null);
  
  println("generate point cloud"); 
  shape = GenPointCloud();
  
  
}



void draw(){
  //background(random(0,255));
  //background(255); 
  
  pushMatrix();

  
  translate(width/2, height/2, 0);
  scale(5 + 25*sin(r));  
  rotateY(rY); 
  rotateX(rY); 
  rotateZ(rY); 
    
    
  shape(shape);
  popMatrix();

 saveFrame("line-######.png");
    
  rY += 0.005;
  k += 0.005;
  r -= 0.005;
  
  
}




PShape GenPointCloud(){
 
    PShape boxCloud = createShape();
    boxCloud.beginShape(POINTS);
    boxCloud.strokeWeight(3);
  
    
   for (float x = -10; x < 10; x++){ 
     for (float y = -10; y < 10; y++){ 
       for (float z = -10; z < 10; z ++){  
    
          float r = (x+10)/20*255;
          float g = (y+10)/20*255;        
          float b = (z+10)/20*255;
         
            println(r + "," + g + "," + b);
            
           //boxCloud.stroke(r,g,b); 
           boxCloud.stroke(r,g,b,5);

           boxCloud.vertex(x,y,z);
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