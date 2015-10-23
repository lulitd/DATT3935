

/*Create a gradient for the ledgend and store it into a PGraphic object to improve preformance 
 *based on setGradient Method from processing linear gradient example
 */

PImage getGradientImg(int w,int h,color c1, color c2, int axis){
  
PGraphics g= createGraphics(w+25,h+25);
  

  g.beginDraw();
  g.noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = 0; i <= h; i++) {
      float inter = map(i, 0, h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      g.stroke(c);
      g.line(0, i,w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = 0; i <= w; i++) {
      float inter = map(i, 0,w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      g.stroke(c);
      g.line(i,0, i, h);
    }
  }
g.endDraw();
  return g;
}


/* Original intention was to store the labels(specifically for the legend) in the Pgraphic with the gradient, however quality was awful for text when rendered
 * So all text is rendered on screen 
 */
void drawLabels(){
  
  textAlign(CENTER,CENTER);
  
  
 
  
  // TITLE
  pushStyle();
  fill(255);
  textFont(titleFont,48);
  text("Toronto's Culture:\n The who's and the where's",(width*.65)/2,height*0.08); 
  popStyle();
  pushStyle();
  // scale label for legend
  fill(maxColor[mode]);
  textFont(titleFont,24);
  text("High",(width*0.015)+(width*0.7)+24,height*0.1+12);
  fill(minColor);
  text("Low",(width*0.015)+(width*0.7)+24,(height*0.75)+(height*0.1)-12);

  
  // title label for legend
  pushMatrix();
  fill(minColor);
  translate((width*0.015)+(width*0.7)+18,((height*0.75)+(height*0.1))/2);
  rotate(PI/2.0);
  text(label[mode],0,0);
  popMatrix();
  popStyle();
  
  image(gradient,width*0.7,height*0.1); // gradient
  
  pushStyle();
  fill(255);
  textSize(36);
  text("Controls:(1-4 key) Mode",(width*.65)/2,height*0.9);
  popStyle();
  
}


void drawBox(String name, float x, float y, float w, float h, int id){
    pushStyle();
    strokeWeight(2);
    stroke(255);
    fill(255,20);
    rect(x,y,w,h);
    fill(255);
    textAlign(LEFT,TOP);
    if (!(height<768))   textFont(titleFont,36);
    else textFont(titleFont,22);
    text(name,x+25,y+25,w-25,height*0.2);
    
   
    String areaCode= toronto.getAttributes().getString(id, 1);
    TableRow row= tableData.findRow(areaCode, 0);
    
   
    if (row !=null){
    pushStyle();
    fill(255,0,0);
    rect(x+15,y+(h*0.375),(w-30)*row.getFloat(1),h*0.075);
    rect(x+15,y+(h*0.525),(w-30)*row.getFloat(2),h*0.075);
    rect(x+15,y+(h*0.675),(w-30)*row.getFloat(3),h*0.075);
    rect(x+15,y+(h*0.825),(w-30)*row.getFloat(4),h*0.075);
    popStyle();
    }
    noFill();
    rect(x+15,y+(h*0.375),w-30,h*0.075);
    rect(x+15,y+(h*0.525),w-30,h*0.075);
    rect(x+15,y+(h*0.675),w-30,h*0.075);
    rect(x+15,y+(h*0.825),w-30,h*0.075);
    popStyle();
    
    textFont(titleFont,18);
    fill(255);
    text("Cultural Location Index",x+10,y+(h*0.175),w-10,height*0.2);
    text("Linguistics Diversity ",x+10,y+(h*0.325),w-10,height*0.2);
    text("Ethnicity Diversity",x+10,y+(h*0.475),w-10,height*0.2);
    text("Average House Cost",x+10,y+(h*0.625),w-10,height*0.2);
    
}