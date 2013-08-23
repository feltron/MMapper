
// - - - - - - - - - - - - - - - - - - - - - - - 
// MOVE OBJECT
// - - - - - - - - - - - - - - - - - - - - - - -  

class Move { 
  String jsonDate;
  String place_name[] = new String[0];
  float place_long[] = new float[0];
  float place_lat[] = new float[0];
  int place_time[] = new int[0];
  float path_long[] = new float[0];
  float path_lat[] = new float[0];
  int path_time[] = new int[0];
  float loc_x[];
  float loc_y[];
  float place_loc_x, place_loc_y, lat_delta, long_delta, dimensionDelta;
  String path_type[] = new String[0];
  String[] dateTime = new String[1];
  String[] PlaceDateTime = new String[1];
  int hours, mins, secs;

  Move(String jsonDate_) {
    jsonDate = jsonDate_;
    jsonFetch(jsonDate);
    // Parse JSON
    JSONArray moves = loadJSONArray(jsonDate + ".json");
    for (int i = 0; i < moves.size(); i++) {
      JSONObject day = moves.getJSONObject(0);
      //      println("Date: " + day.getString("date"));
      JSONArray segments = day.getJSONArray("segments");
      //      println(day.getString("date") + ": " + segments.size() + " SEGMENTS");
      for (int j = 0; j < segments.size(); j++) {
        //        println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
        //        println("Segment Number: " + j);
        JSONObject segment = segments.getJSONObject(j);
        //        println("Type: " + segment.getString("type"));
        //        println("Start Time: " + segment.getString("startTime"));
        //        println("End Time: " + segment.getString("endTime"));
        try {
          JSONArray activities = segment.getJSONArray("activities");
          for (int k = 0; k < activities.size(); k++) {
            JSONObject activity = activities.getJSONObject(k);
            //            println("Activity: " + activity.getString("activity"));
            //            println("Start Time: " + activity.getString("startTime"));
            //            println("End Time: " + activity.getString("endTime"));
            //            println("Duration: " + activity.getInt("duration"));
            if (activity.getString("activity").equals("wlk") || activity.getString("activity").equals("run")) {
              //              println("Distance: " + activity.getInt("distance"));
              //              println("Steps: " + activity.getInt("steps"));
            }
            JSONArray path = activity.getJSONArray("trackPoints");
            for (int l = 0; l < path.size(); l++) {
              JSONObject point = path.getJSONObject(l);
              //              println("- Lat: " + point.getFloat("lat"));
              //              println("- Long: " + point.getFloat("lon"));
              //              println("- Time: " + point.getString("time"));
              // build path array
              path_type = append(path_type, activity.getString("activity"));
              path_long = append(path_long, point.getFloat("lon"));
              path_lat = append(path_lat, point.getFloat("lat"));
              dateTime = split(point.getString("time"), 'T');
              dateTime = split(dateTime[1], 'Z');
              path_time = append(path_time, int(dateTime[0]));
              // convert path_time to minutes
              hours = floor(path_time[path_time.length-1]*0.0001);
              mins = floor((path_time[path_time.length-1] - hours*10000)*0.01);
              secs = path_time[path_time.length-1] - hours*10000 - mins*100;
              path_time[path_time.length-1] = hours*3600 + mins*60 + secs;
            }
          }
        }
        catch (Exception e) {
          //          println("error "+e);
        }
        try {
          JSONObject place = segment.getJSONObject("place");
//          println("Start Time: " + segment.getString("startTime"));
//          println("* " + place.getString("name"));
          //          println("* Type: " + place.getString("type"));
          //          println("* ID: " + place.getInt("id"));
          JSONObject location = place.getJSONObject("location");
          //          println("* Lat: " + location.getFloat("lat"));
          //          println("* Long: " + location.getFloat("lon"));
          // build unique places array
          place_name = append(place_name, place.getString("name"));
          place_long = append(place_long, location.getFloat("lon"));
          place_lat = append(place_lat, location.getFloat("lat"));
          // compute place_time in minutes
          PlaceDateTime = split(segment.getString("startTime"), 'T');
//          println(PlaceDateTime);
          PlaceDateTime = split(PlaceDateTime[1], 'Z');
//          println(PlaceDateTime);
          place_time = append(place_time, int(PlaceDateTime[0]));
          // convert path_time to minutes
          hours = floor(place_time[place_time.length-1]*0.0001);
          mins = floor((place_time[place_time.length-1] - hours*10000)*0.01);
          secs = place_time[place_time.length-1] - hours*10000 - mins*100;
          place_time[place_time.length-1] = hours*3600 + mins*60 + secs;

        }
        catch (Exception e) {
          //          println("error "+e);
        }
      }
    }
    max_lats.set(jsonDate, max(path_lat));
    min_lats.set(jsonDate, min(path_lat));
    max_longs.set(jsonDate, max(path_long));
    min_longs.set(jsonDate, min(path_long));
  }


  void display() {
    // Draw Paths
    noFill();
    for (int i=0; i<path_long.length; i++) {
      if ( i>0 && path_type[i].equals("cyc") && cycle.booleanValue() && path_time[i] < TimeOfDay) {
        stroke(0, 255, 255, 100);
        line(loc_x[i], loc_y[i], loc_x[i-1], loc_y[i-1]);
      } 
      else if ( i>0 && path_type[i].equals("run") && run.booleanValue() && path_time[i] < TimeOfDay) {
        stroke(255, 0, 255, 100);
        line(loc_x[i], loc_y[i], loc_x[i-1], loc_y[i-1]);
      }
      else if ( i>0 && path_type[i].equals("wlk") && walk.booleanValue() && path_time[i] < TimeOfDay) {
        stroke(255, 255, 0, 100);
        line(loc_x[i], loc_y[i], loc_x[i-1], loc_y[i-1]);
      }
      else if ( i>0 && path_type[i].equals("trp") && transportation.booleanValue() && path_time[i] < TimeOfDay) {
        stroke(255, 40);
        line(loc_x[i], loc_y[i], loc_x[i-1], loc_y[i-1]);
      }
    }
    // Draw Places
    noStroke();
    for (int i=0; i<place_long.length; i++) {
      if (placesDrawn.hasKey(place_name[i])) {
      } 
      else if ( labels.booleanValue() && place_time[i] < TimeOfDay ) {
        place_loc_x = map(place_long[i], min_long, max_long, margin, canvasSize-margin);
        place_loc_y = map(place_lat[i], max_lat, min_lat, 80, canvasSize-margin);
        fill(255);
        ellipse(place_loc_x, place_loc_y, placeSize, placeSize);
        fill(255, 150);
        textSize(9);
        text(place_name[i], place_loc_x+placeSize, place_loc_y+3);
        placesDrawn.set(place_name[i], "true");
      }
    }
  }


  void mapBounds() {
    float max_lats_array[] = new float[0];
    float min_lats_array[] = new float[0];
    float max_longs_array[] = new float[0];
    float min_longs_array[] = new float[0];
    for (int i=0; i<movesDates.length; i++) {
      try {
        max_lats_array = append(max_lats_array, max_lats.get(str(movesDates[i])));
        min_lats_array = append(min_lats_array, min_lats.get(str(movesDates[i])));
        max_longs_array = append(max_longs_array, max_longs.get(str(movesDates[i])));
        min_longs_array = append(min_longs_array, min_longs.get(str(movesDates[i])));
      }
      catch (Exception e) {
      }
    }
    max_lat = max(max_lats_array);
    min_lat = min(min_lats_array);
    max_long = max(max_longs_array);
    min_long = min(min_longs_array);
    //    println(max_lat + " / " + min_lat + " / " + max_long + " / " + min_long);
  }


  void mapPaths() {
    loc_x = new float[path_long.length];
    loc_y = new float[path_lat.length];
    long_delta = abs(max_long-min_long)/2;
    lat_delta = abs(max_lat-min_lat);
    if (long_delta > lat_delta) {
      //      println( "long greater " + long_delta/lat_delta/2 + " / " + min_lat + " / " + max_lat );
      for (int i=0; i<path_long.length; i++) {
        loc_x[i] = map(path_long[i], min_long, max_long, margin, canvasSize-margin);
        loc_y[i] = map(path_lat[i], max_lat, min_lat, 80, canvasSize-margin);
      }
    }
    else {
      //      println("lat greater " + lat_delta/long_delta/2 + " / " + min_long + " / " + max_long);
      for (int i=0; i<path_long.length; i++) {
        loc_x[i] = map(path_long[i], min_long, max_long, margin, canvasSize-margin);
        loc_y[i] = map(path_lat[i], max_lat, min_lat, 80, canvasSize-margin);
      }
    }
  }


  void jsonFetch(String fetchDate) {
    File f = new File(dataPath( fetchDate + ".json" ));
    if ( !f.exists() ) { // Call API if data doesn't exist
      try {
        println("Querying… " + fetchDate);
        apiCall = "https://api.moves-app.com/api/v1/user/storyline/daily/" + fetchDate + "?trackPoints=true&access_token=" + accessToken;
        JSONArray result = loadJSONArray( apiCall );
        if (result != null) { // unsure if this call works
          saveJSONArray(result, dataPath(fetchDate + ".json"));
        }
      } 
      catch (Exception e) {
        println("No Data");
      }
    }
  }
}

