import org.gicentre.geomap.*; // Used to load in shpfile
PFont titleFont;

final int Y_AXIS = 1;
final int X_AXIS = 2;

// storage
GeoMap toronto;
Table tableData;

// visuals 
color minColor=#FFFFB3;
color[] maxColor={#FF6100,#0055DB,#6126DB,#13871B};
String[] label= {"Cultural Location Index","Linguistic diversity Index","Ethnicity Index","Average House Cost"};
float[] dataMax={0.98,0.877982435,0.593214863,0.914071511};
PImage gradient;

int compareID1,compareID2;
String name1,name2;
boolean controls=false;
int mode;

// size settings are seperated from setup as I wanted the visualization to be adaptable to various screen sizes. Fonts are still need to be scaled properly
void settings() {
//  size(1024, 761,P2D);
fullScreen(P2D);
}

void setup() {
  //settings(); //Uncomment for sketch to work properly in processing 2. settings() is a new method in version 3 that is called before setup(). 
  mode=0;
  
  // Set up text appearance.
  textAlign(LEFT, BOTTOM);
  titleFont= loadFont("OstrichSansBlack.vlw");
  
  toronto= new GeoMap(width*0.025,height*0.15,width*0.65,height*0.65,this); // setting the size and location of map
  gradient= getGradientImg(round(width*0.015),round(height*0.75),maxColor[mode],minColor,Y_AXIS ); // creating the gradient legend for map
  
  toronto.readFile("toronto"); // reading the shp file of toronto neighbourhoods

  // loading data 
  tableData= loadTable("neighbourhoods.csv", "header,csv");
  
  name1="Neighbourhood:(LEFT CLICK)\n";
  name2="Neighbourhood:(RIGHT CLICK)\n";


}

void draw() {
  background(100);
  
  strokeWeight(1);
  stroke(75,50);


  // start of map drawing
  for (int id : toronto.getFeatures().keySet()) {

    String areaCode= toronto.getAttributes().getString(id, 1);
   
    TableRow row= tableData.findRow(areaCode, 0);

    // tow matches areaCode
    if (row!=null) {
      float data= row.getFloat(mode+1)/dataMax[mode];
      
      
      fill(lerpColor(minColor, maxColor[mode], data));
    } 
    else { 
      fill(255);
    }

    // draw neighbourhood id
    toronto.draw(id);
  }
  

  

 // Outline the selected neighbourhood 
   if (compareID1!=-1){
    strokeWeight(2);
    stroke(255);
    fill(0,50);
    toronto.draw(compareID1);
    
    name1 = "Neighbourhood:(LEFT CLICK)\n"+toronto.getAttributes().getString(compareID1, 2);
   }
   else {
   name1 = "Neighbourhood:\n";
   
   }
   
   // Outline the selected Neighbourhood
  if (compareID2!=-1){
    strokeWeight(2);
    stroke(255);
    fill(0,50);
    toronto.draw(compareID2);
    name2 = "Neighbourhood:(RIGHT CLICK)\n"+ toronto.getAttributes().getString(compareID2, 2);
   }
   else {
    name2 = "Neighbourhood:(RIGHT CLICK)\n"; 
   }
   
 // draws the box on the Right
    drawBox(name1,width*0.775,height*0.05,width*0.21,height*0.425,compareID1);
    drawBox(name2,width*0.775,height*0.525,width*0.21,height*0.425,compareID2);

  
  
    // Query the neighbourhood at the mouse position.
  int id = toronto.getID(mouseX, mouseY);
  
  if (id != -1)
  {
    strokeWeight(2);
    stroke(250);
    fill(25,50);
    toronto.draw(id);
   
    String name = toronto.getAttributes().getString(id, 2);
    fill(50);
    if (!(height<768))   textFont(titleFont,28);
    else textFont(titleFont,18);
    textAlign(LEFT,BOTTOM);
    text(name, mouseX+10, mouseY-10);
  }

  drawLabels();
 
}