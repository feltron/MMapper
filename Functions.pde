
// Initialize Empty Checkbox GUI 
// - - - - - - - - - - - - - - - - - - - - - - - 
void GUIcheckbox(String name_, int xpos_, int ypos_) {
  checkbox = cp5.addCheckBox(name_)
    .setPosition(xpos_, ypos_)
      .setColorForeground(color(190))
        .setColorBackground(color(60))
          .setColorActive(color(255, 128))
            .setColorLabel(color(255))
              .setSize(15, 15)
                .setItemsPerRow(7)
                  .setSpacingColumn(20)
                    .setSpacingRow(10)
                      ;
}

// Initialize Empty Months Dropdown GUI
// - - - - - - - - - - - - - - - - - - - - - - - 
void GUIdropdownD1(String name_, int xpos_, int ypos_, String label_) {
  d1 = cp5.addDropdownList(name_)
    .setPosition(xpos_, ypos_)
      .setItemHeight(20)
        .setBarHeight(15)
          .setColorBackground(color(60))
            .setColorActive(color(255, 128))
              ;
  d1.captionLabel().style().marginTop = 3;
  d1.valueLabel().style().marginTop = 3;
  d1.captionLabel().set(label_);
}


// Initialize Empty Years Dropdown GUI 
// - - - - - - - - - - - - - - - - - - - - - - - 
void GUIdropdownD2(String name_, int xpos_, int ypos_, String label_) {
  d2 = cp5.addDropdownList(name_)
    .setPosition(xpos_, ypos_)
      .setItemHeight(20)
        .setBarHeight(15)
          .setColorBackground(color(60))
            .setColorActive(color(255, 128))
              ;
  d2.captionLabel().style().marginTop = 3;
  d2.valueLabel().style().marginTop = 3;
  d2.captionLabel().set(label_);
}


// Populate Months Dropdown 
// - - - - - - - - - - - - - - - - - - - - - - - 
void GUImonth(int year_, int month_, int monthSet) {
  if (year_ == year()) {
    for (int i=1; i<=month_; i++) {
      d1.addItem(monthNames[i-1], i);
    }
    d1.setValue(monthSet);
  } 
  else {
    for (int i=1; i<=monthNames.length; i++) {
      d1.addItem(monthNames[i-1], i);
    }
    d1.setValue(1);
  }
}


// Populate Years Dropdown 
// - - - - - - - - - - - - - - - - - - - - - - - 
void GUIyear(int year_) {
  for (int i=1; i+2011<=year_; i++) {
    d2.addItem(str(i+2011), i+2011);
  }
  d2.setValue(year_);
}


// Populate Days Dropdown 
// - - - - - - - - - - - - - - - - - - - - - - - 
void GUIday(int year_, int month_, int day_) {
  if (month_ == month() && year_ == year()) {
    for (int i=1; i<=day(); i++) {
      checkbox.addItem(str(i), i);
    }
    checkbox.toggle(day_-1);
  } 
  else {
    if (int(d2.getValue()) % 4 == 0) {
      for (int i=1; i<=int(monthDaysLeap[month_-1]); i++) {
        checkbox.addItem(str(i), i);
      }
      checkbox.toggle(0);
    } 
    else {
      for (int i=1; i<=int(monthDaysStandard[month_-1]); i++) {
        checkbox.addItem(str(i), i);
      }
      checkbox.toggle(0);
    }
  }
}


// GUI Event Listener
// - - - - - - - - - - - - - - - - - - - - - - - 
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(checkbox)) {
    listDates();
    for (int i=0; i<movesDates.length; i++) {      
      try {
        moves.get(str(movesDates[i])).mapBounds();
        moves.get(str(movesDates[i])).mapPaths();
      }
      catch (Exception e) {
      }
    }
  } 
  else if (theEvent.isFrom("d2-year") && frameCount > 2) {
    checkbox.remove();
    GUIday(int(d2.getValue()), 1, 1);
    d1.clear();
    GUImonth(int(d2.getValue()), month(), 1);
  }
  else if (theEvent.isFrom("d1-month") && frameCount > 2) {
    checkbox.remove();
    GUIcheckbox("checkbox", 150, height-135);
    GUIday(int(d2.getValue()), int(d1.getValue()), 1);
  }
}


// Format Events into Array of Dates 
// - - - - - - - - - - - - - - - - - - - - - - - 
void listDates() {
  movesDates = new int[0];
  for (int i=0; i<checkbox.getArrayValue().length; i++) {
    if (checkbox.getArrayValue(i) != 0) {
      if (d1.getValue() <= 9) {
        month = "0" + str(int(d1.getValue()));
      } 
      else {
        month = str(int(d1.getValue()));
      }
      if (i < 9) {
        day = "0" + str(i+1);
      } 
      else {
        day = str(i+1);
      }
      year = str(int(d2.getValue()));
      date = year + month + day;
      movesDates = append(movesDates, int(date));
    }
  }
  println("- - - - - - - - - - - - - - -");
  makeMoves();
}


// Add Elements as necessary to Moves hashmap
// elements in hashmap that shouldn't be shown won't be called in display function
// - - - - - - - - - - - - - - - - - - - - - - - 
void makeMoves() {
  for (int i=0; i<movesDates.length; i++) {
    if ( moves.containsKey(str(movesDates[i])) ) {
      //            println("Object key found: " + (movesDates[i]) +  " do nothing");
    } 
    else {
      //            println("Object key not found: " + (movesDates[i]) +  " add to hashmap");
      moves.put( str(movesDates[i]), new Move(str(movesDates[i])) );
    }
  }

  for (String k : moves.keySet()) {
    moves.get(k).mapPaths();
  }
}


// Format Minutes into Hour:Minute:Second Format for Time Scrubber 
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
void timeLabel() {
  String TimeOfDay_hour = str(floor(TimeOfDay/3600));
  String TimeOfDay_min = str(floor((TimeOfDay-int(TimeOfDay_hour)*3600)/60));
  String TimeOfDay_sec = str(TimeOfDay-int(TimeOfDay_hour)*3600-int(TimeOfDay_min)*60);

  if (TimeOfDay_hour.length() == 1) {
    TimeOfDay_hour = "0" + TimeOfDay_hour;
  } else if (TimeOfDay_min.length() == 1) {
    TimeOfDay_min = "0" + TimeOfDay_min;
  } else if (TimeOfDay_sec.length() == 1) {
    TimeOfDay_sec = "0" + TimeOfDay_sec;
  }

//  println(TimeOfDay_hour + ":" + TimeOfDay_min + ":" + TimeOfDay_sec);
  TimeString = TimeOfDay_hour + ":" + TimeOfDay_min + ":" + TimeOfDay_sec + " UTC" + " " + tzOffsetLabel;

  cp5.getController("TimeOfDay").getValueLabel().setText(TimeString);
}



