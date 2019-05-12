import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
PVector pMedio=new PVector(0,0);
boolean image=false;
boolean tresD=false;

void setup() 
{
  size(960, 720, P3D);
  video = new Capture(this,640/2,480/2);
  opencv = new OpenCV(this,640/2,480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  rectMode(CENTER);
  video.start();
  if(image)
  {
    noFill();
    stroke(0,255,0);
  }
  else
  {
    noFill();
    stroke(255);
  }
}
void draw() 
{
  //scale(2);
  opencv.loadImage(video);
  if(image)image(video,0,0);
  Rectangle[] faces = opencv.detect();
  if(faces.length>0)
  { 
    Ojos ojoD, ojoI, ojoC;
    ojoD=new Ojos(true, faces[0].x+faces[0].width/8, faces[0].y+faces[0].height/3.5, faces[0].width/3, faces[0].height/5);
    ojoI=new Ojos(false, faces[0].x+faces[0].width/1.9, faces[0].y+faces[0].height/3.5, faces[0].width/3, faces[0].height/5);
    pMedio.set((ojoD.x+ojoI.x)/2+ojoD.tamX/1.9,ojoD.y);
    ojoC=new Ojos(true,(ojoD.x+ojoI.x)/2+ojoD.tamX/1.9,ojoD.y,20,20);
    if(image)
    {
      ellipse(ojoC.x,ojoC.y,ojoC.tamX,ojoC.tamY);
      ojoD.display();
      ojoI.display();
    }
    else
    {
      background(0);
      strokeWeight(2);
      noFill();
      if(tresD)
      {
        float tx,ty;
        tx=map(ojoC.x,0,width/2,-width,width)+width/1.3;
        ty=map(ojoC.y,0,height/2,-height,height)+height/1.3;
        camera(tx, ty, (height/2)/tan(PI*30.0 / 180.0), 
               width/2, height/2, 0, 0, 1, 0);
      }
      for(int z=-5; z<12; z++)
      {
        pushMatrix();
        translate(0,0,-z*100);
        if(z==11)strokeWeight(3);
        stroke(constrain(255-z*20,0,255));
        rect(width/2,height/2,width,height);
        popMatrix();
      }
      directionalLight(170,70,28,0,0,-1);
      fill(255);
      noStroke();
      translate(width/2,height/2,100);
      sphere(100);
      directionalLight(70,70,170,0,0,-1);
      translate(-width/4,-height/7,-550);
      sphere(100);
      directionalLight(100,200,70,0,0,-1);
      translate(width/2.4,height/3,-100);
      sphere(100);
    }
  }
}
void captureEvent(Capture c) 
{
  c.read();
}
void keyPressed()
{
  if(key==' ')tresD=true;
}
