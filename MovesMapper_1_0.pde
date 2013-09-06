
// - - - - - - - - - - - - - - - - - - - - - - - 
// MOVES MAPPER v1.1
// Nicholas Felton — September 4, 2013
// - - - - - - - - - - - - - - - - - - - - - - - 


// - - - - - - - - - - - - - - - - - - - - - - - 
// LIBRARIES
// - - - - - - - - - - - - - - - - - - - - - - - 
import controlP5.*;
import java.util.Map;


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
  GUIdropdownD3("d3-timezone", width-120, 45, "TIMEZONE");

  // Populate Date GUI
  GUItimezone();
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

  // add a horizontal slider
  cp5.addSlider("TimeOfDay")
    .setPosition(margin, margin)
      .setSize(width-(2*margin)-110, 10)
        .setRange(0, 86400)
          .setValue(86400)
            .setColorForeground(color(190))
              .setColorBackground(color(60))
                .setColorActive(color(255, 128))
                  ;

  // reposition the Label for controller 'slider'
  cp5.getController("TimeOfDay").getValueLabel().setText(TimeString).align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("TimeOfDay").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  d3.setLabel("Time Zone");
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

