void keyPressed(){
 switch(key){
   
  case '1': mode=0; // culture
  gradient= getGradientImg(round(width*0.015),round(height*0.75),maxColor[mode],minColor,Y_AXIS ); // creating the gradient legend for map
         break;
  case '2': mode=1; // lingusitics
  gradient= getGradientImg(round(width*0.015),round(height*0.75),maxColor[mode],minColor,Y_AXIS ); // creating the gradient legend for map
         break;
  case '3': mode=2; // ethicity
  gradient= getGradientImg(round(width*0.015),round(height*0.75),maxColor[mode],minColor,Y_AXIS ); // creating the gradient legend for map
         break;
  case '4': mode=3; // cost
  gradient= getGradientImg(round(width*0.015),round(height*0.75),maxColor[mode],minColor,Y_AXIS ); // creating the gradient legend for map
         break;
  default:break ;
}
}


void mousePressed(){
  

    
    if (mouseButton==LEFT){
     // Query the neighbourhood at the mouse position.
    compareID1 = toronto.getID(mouseX, mouseY);    
    }
    
    else if(mouseButton==RIGHT){
         // Query the neighbourhood at the mouse position.
    compareID2 = toronto.getID(mouseX, mouseY);
 //   println("right Clicked");
}
   
  
}