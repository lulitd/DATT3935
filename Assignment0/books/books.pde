/* _/|BookShelf|\\_
* A visualization of Postsecondary enrolments by Field of Study in Canada(2012/13)
* Author: Lalaine Ulit-Destajo
*Course: DATT3935
* Dataset(original): http://www.statcan.gc.ca/tables-tableaux/sum-som/l01/cst01/educ72a-eng.htm
* Dataset(precents): attached percent.pdf
*/




int shelfThickness=30; // shelf thickness
float maxBookWidth;
float maxBookHeight;
boolean isStats=true; // shows total stats
boolean isHidden=false; // hover Toggle
boolean isgrid=false;// hides grid

Book[] books= new Book[15]; // each book
PVector [] shelfCenters= new PVector[15]; // location center of area
PVector [] shelves= new PVector[15]; // shelves
float [] precent= {0.2,0.86,0.57,0.58,0.82,0.63,0.94,0.66,0.58,0.71,0.63,0.15,0.36,0,0}; // percent University
float [] bookScale= {0.06, 0.24, 0.21, 0.79, 0.67,0.91, 0.32, 0.14, 0.49, 0.07, 0.59, 0.11, 0.41, 0,0}; // scale factor precent/20 
String[] percents={"1%", "5%", "4%", "16%", "13%", "18%", "6%", "3%", "10%", "1%", "12%", "2%", "8%"};// total precent
String[] percentsU={"20%", "86%", "57%", "58%", "82%", "63%", "94%", "66%", "58%", "71%", "63%", "15%", "36%"}; // university percent
String[] percentsC={"80%", "14%", "43%", "42%", "18%", "37%", "6%", "34%", "42%", "29%", "37%", "85%", "64%"}; // college precent
String[] labels={"Personal improvement", "Education", "Arts and Comn.", "Humanities", "SocialSci & law", "Bussiness&Admin", "Physical&lifeSci", "Math&ComSci", "Architecture&Engineering", "Agriculture&Conserv.", "Health&Fitness", "Protective&transportation", "other", ".", "."};
String description="A visualzation of Postsecondary enrolments by Field of Study in Canada(2012/13)";

void setup() {
  
  size(1024, 768);
  textAlign(CENTER);
  if(!isHidden){noLoop();}// Stop it from drawing when there are no updates
  maxBookWidth=width/5.0;
  maxBookHeight=height/4.0;

  int counter=0;
  for (int i=0; i<3; i++) {
    for (int j=0; j<5; j++) {

      shelfCenters[counter]= new PVector((width/5.0*j)+((width/5.0)/2.0), (height/3.0*i)+(((height/3.0)/2.0)));
      shelves[counter]= new PVector((width/5.0*j)+((width/5.0)/2.0), (height/3.0*(i+1.0))-shelfThickness/5.0);
      println(shelfCenters[counter]);
      counter++;
    }
  }

// set all params for books
  for ( int i=0; i <15; i++) {

    books[i]= new Book();
 
    books[i].setSize(maxBookWidth/3.0, maxBookHeight*bookScale[i]);
    books[i].setLoc(shelfCenters[i].x, (shelfCenters[i].y+(height/3.0-books[i].iHeight)/2)-shelfThickness);
    books[i].setCol(color(255, 0, 0));
    books[i].setPercent(precent[i]);
  }
}



/*************************************MAIN DRAW**********************/
void draw() {
  background(29,24,19);


  for (int i=0; i< books.length; i++) {
    if (!(i==13||i==14)) { // shelfspace 13 and 14 will not have books but contain the label
      books[i].drawBook();
    }
  }
  // draws the hovering stats
  
if (isHidden){
drawHover();
}

  drawShelves();
 if (isgrid){ drawGrid();}
  drawLabel();

}

/********Draw the stats on over***********/
void drawHover() {

  int locationIndex=checkLocation();// get index based on mouse location

 // check if indexes don't have the books!
  if (locationIndex!=13 && locationIndex!=14 && locationIndex!=15) {
    // fade out books
    pushStyle();
      fill(125, 200);
      noStroke();
      rect(shelfCenters[locationIndex].x, shelfCenters[locationIndex].y, width/5.0, height/3.0);
    
    // text stats
      fill(255);
      textSize(24);
      // total precents
      if (isStats){text(percents[locationIndex]+" of Total Enrolment", shelfCenters[locationIndex].x,shelfCenters[locationIndex].y, width/5.0,72);}
    
    // College/university stats
    else{
      fill(255,0,0);
      text("University: "+percentsU[locationIndex], shelfCenters[locationIndex].x, shelfCenters[locationIndex].y);
      fill(255,255,0);
      text("College: "+percentsC[locationIndex], shelfCenters[locationIndex].x, shelfCenters[locationIndex].y+36);
    }
    popStyle();
  }
}

void drawShelves() {
  pushStyle();
  fill(248);
  noStroke();
  rectMode(CORNER);
  rect(0, height/3.0-shelfThickness, width, shelfThickness);
  rect(0, height/3.0*2.0-shelfThickness, width, shelfThickness+3);
  rect(0, height-shelfThickness, width, shelfThickness);
  popStyle(); 


  for (int i=0; i< shelves.length; i++) {
    if (!(i==13||i==14)) { 
      pushStyle();
      fill(0);
      textSize(12);
      text(labels[i], shelves[i].x, shelves[i].y, maxBookWidth, shelfThickness);
      popStyle();
    }
  }
}

// draw vertical lines
void drawGrid() {
  pushStyle();
  stroke(255);
  float tempGridWidth=width/5.0;

  for ( int i=0; i<4; i++) {

    if (i==3) {
     // line(tempGridWidth, 0, tempGridWidth, height/3.0*2.0);
     line(tempGridWidth, 0, tempGridWidth, height);
    } else {
      line(tempGridWidth, 0, tempGridWidth, height);
    }
    tempGridWidth= tempGridWidth+width/5.0;
  }
  popStyle();
}

// draw Label
void drawLabel(){
   pushStyle();
  textSize(32);
  textAlign(CENTER);
  text("_/|BookShelf|\\_", shelfCenters[13].x+(maxBookWidth/2), shelfCenters[13].y-80);
  textSize(18);
  text(description, shelfCenters[13].x+(maxBookWidth/2), shelfCenters[13].y+6, width/5*1.5, height/6);
  textSize(16);
  text("[d]:Display Stats [s]:Switch Stats", shelfCenters[13].x+maxBookWidth/2, shelfCenters[13].y+105, width/5*2, height/6);
  
  fill(255,0,0);
   textAlign(RIGHT);
   text("University",  shelfCenters[13].x+80, shelfCenters[13].y+84);
   fill(255,255,0);
    textAlign(LEFT);
    text("College", shelfCenters[14].x-80, shelfCenters[14].y+84);
  
  popStyle(); 
  
}


int checkLocation() {
  int modX= mouseX/(width/5); // calculates xPos index
  int mody= mouseY/(height/3); // calculates yPos index
  return (mody*5)+modX; // converts [x,y] 2d index into 1D index
}


// key controls
void keyPressed(){  
 
  switch(key){
    case 's': isStats=!isStats;
    break;
    case 'S': isStats=!isStats;
    break;
    
    case 'D': isHidden=!isHidden;
    break;
    case 'd': isHidden=!isHidden;
    break;  
    
    case '!': saveFrame("frame"+frameCount+".png"); 
    println("PRINT!");
    break;
  }
  
  if(isHidden){
    
   loop(); // redraw
  }
}