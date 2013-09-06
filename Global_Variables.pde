
// - - - - - - - - - - - - - - - - - - - - - - - 
// GLOBAL VARIABLES
// - - - - - - - - - - - - - - - - - - - - - - - 

// Constants
int canvasSize = 800; // 550 minimum value
int placeSize = 6;
int margin = 30;

// Data
int[] movesDates;
HashMap<String, Move> moves = new HashMap<String, Move>();
FloatDict max_lats = new FloatDict();
FloatDict min_lats = new FloatDict();
FloatDict max_longs = new FloatDict();
FloatDict min_longs = new FloatDict();
float max_lat, min_lat, max_long, min_long;
StringDict placesDrawn = new StringDict();

// GUI
ControlP5 cp5;
DropdownList d1, d2, d3;
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
String[] timeZoneOffsets = { 
  "-12", "-11", "-10", "-9.5", "-9", "-8", "-7", "-6", "-5", "-4.5", "-4", "-3.5", "-3", "-2", "-1", "0", "1", "2", "3", "3.5", "4", "4.5", "5", "5.5", "5.75", "6", "6.5", "7", "8", "8.75", "9", "9.5", "10", "10.5", "11", "11.5", "12", "12.75", "13", "14"
};
String[] timeZoneOffsetNames = { 
  " ", "Midway Island", "Hawaii", "Fr. Polynesia", "Alaska", "Pacific", "Mountain", "Central", "Eastern", "Venezuela", "Atlantic", "Newfoundland", "Brazil", "Mid-Atlantic", "Azores", "Western Europe", 
  "Central Europe", "Eastern Europe", "Middle East", "Iran", "Western Russia", "Afghanistan", "Pakistan", "India", "Nepal", "Kazakhstan", "Burma", "Thailand", "China", " ", "Japan", "Cent. Australia",
  "East Australia", "Lord Howe Isl.", "Solomon Isl.", "Norfolk Isl.", "New Zealand", "Chatham Isl.", "Tonga", " "
};
int TimeOfDay;
String TimeString = "00:00:00";
int tzOffset;
int timeZoneOffsetIndex = 10; // default time zone offset for Atlantic time

