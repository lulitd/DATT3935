public class Book{

  float xPos; 
  float yPos;
  float iWidth;
  float iHeight;
  float precent;
  color col;

public Book(){
  rectMode(CENTER);
}

public void setSize( float w, float h){
 this.iWidth=w; 
 this.iHeight=h;
}

public void setLoc(float x, float y){
 this.xPos=x;
 this.yPos=y;
}

public void setCol(color c){
  this.col= c;
}

public void setPercent(float f){
  this.precent= f;
}

public void drawBook(){
  pushStyle();
     fill(col);
     noStroke();
     rect(xPos,yPos, iWidth, iHeight); // draw book 
     fill(255,255,0);
         pushStyle();
         rectMode(CORNER);
         noStroke();
         rect(xPos-iWidth*(0.5-precent),yPos-iHeight/2,iWidth-(iWidth*precent),iHeight); // draw college precent
         popStyle();
    strokeWeight(2.5);
    line(xPos-iWidth*(0.5-precent),yPos-iHeight/2,xPos-iWidth*(0.5-precent),yPos+iHeight/2); // draw line
 popStyle();
  
}




}