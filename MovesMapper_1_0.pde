// - - - - - - - - - - - - - - - - - - - - - - - 
// MOVES MAPPER v1.0
// Nicholas Felton — September 3, 2013
// - - - - - - - - - - - - - - - - - - - - - - - 


// - - - - - - - - - - - - - - - - - - - - - - - 
// LIBRARIES
// - - - - - - - - - - - - - - - - - - - - - - - 
import controlP5.*;
import java.util.Map;


// - - - - - - - - - - - - - - - - - - - - - - - 
// GLOBAL VARIABLES
// - - - - - - - - - - - - - - - - - - - - - - - 

// General
int canvasSize = 800; // 550 minimum value

// Data
String date, year, month, day;
int[] movesDates;
String apiCall;
HashMap<String, Move> moves = new HashMap<String, Move>();

// Draw
int placeSize = 6;
FloatDict max_lats = new FloatDict();
FloatDict min_lats = new FloatDict();
FloatDict max_longs = new FloatDict();
FloatDict min_longs = new FloatDict();
float max_lat, min_lat, max_long, min_long;
float mapOffset;
StringDict placesDrawn = new StringDict();
int margin = 30;
int top_margin = margin + 50;

// GUI
ControlP5 cp5;
DropdownList d1, d2;
CheckBox checkbox;
Button labels, walk, run, cycle, transportation;
String[] monthNames = {
  "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
};
String[] monthDaysStandard = {
  "31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31"
};
String[] monthDaysLeap = {
  "31", "29", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31"
};
int TimeOfDay;
String TimeString = "00:00:00";


// - - - - - - - - - - - - - - - - - - - - - - - 
// SETUP
// - - - - - - - - - - - - - - - - - - - - - - - 
void setup() {
  size(canvasSize, canvasSize+150);
  smooth();
  hint(ENABLE_STROKE_PURE);
  cp5 = new ControlP5(this);

  // Instantiate Date GUI
  GUIcheckbox("checkbox", 150, height-135);
  GUIdropdownD1("d1-month", 20, height-95, "MONTH");
  GUIdropdownD2("d2-year", 20, height-120, "YEAR");

  // Populate Date GUI
  GUImonth(year(), month(), month());
  GUIyear(year());
  GUIday(year(), month(), day());

  // Additional GUI
  labels = cp5.addButton("labels")
    .setPosition(width-120, height-135)
      .setSize(100, 20)
        .setHeight(15)
          .setColorForeground(color(190))
            .setColorBackground(color(60))
              .setColorActive(color(255, 128))
                .setSwitch(true)
                  .setOn()
                  ;

  walk = cp5.addButton("walk")
    .setPosition(width-120, height-110)
      .setSize(100, 20)
        .setHeight(15)
          .setColorForeground(color(45))
            .setColorBackground(color(60))
              .setColorActive(color(255, 128))
                .setSwitch(true)
                  .setOn()
                  ;

  run = cp5.addButton("run")
    .setPosition(width-120, height-85)
      .setSize(100, 20)
        .setHeight(15)
          .setColorForeground(color(190))
            .setColorBackground(color(60))
              .setColorActive(color(255, 128))
                .setSwitch(true)
                  .setOn()
                  ;

  cycle = cp5.addButton("cycle")
    .setPosition(width-120, height-60)
      .setSize(100, 20)
        .setHeight(15)
          .setColorForeground(color(190))
            .setColorBackground(color(60))
              .setColorActive(color(255, 128))
                .setSwitch(true)
                  .setOn()
                  ;

  transportation = cp5.addButton("transportation")
    .setPosition(width-120, height-35)
      .setSize(100, 20)
        .setHeight(15)
          .setColorForeground(color(190))
            .setColorBackground(color(60))
              .setColorActive(color(255, 128))
                .setSwitch(true)
                  .setOn()
                  ;

  // add a vertical slider
  cp5.addSlider("TimeOfDay")
    .setPosition(margin, margin)
      .setSize(width-(2*margin), 10)
        .setRange(0, 86400)
          .setValue(86400)
            .setColorForeground(color(190))
              .setColorBackground(color(60))
                .setColorActive(color(255, 128))
                  ;

  // reposition the Label for controller 'slider'
  cp5.getController("TimeOfDay").getValueLabel().setText(TimeString).align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("TimeOfDay").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
}


// - - - - - - - - - - - - - - - - - - - - - - - 
// DRAW LOOP
// - - - - - - - - - - - - - - - - - - - - - - - 

void draw() {
  frame.setTitle(int(frameRate) + " fps / " + frameCount + " frames");
  background(40);
  placesDrawn.clear();
  timeLabel();

  // Draw Moves
  for (int i=0; i<movesDates.length; i++) {      
    try {
      moves.get(str(movesDates[i])).display();
    }
    catch (Exception e) {
    }
  }
}
