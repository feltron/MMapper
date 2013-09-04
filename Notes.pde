
// SETUP
// 1. Open Moves app and make sure that your activity is up to date.
// 2. In the settings, go to the Apps section and click the add a PIN button.
// 3. Visit http://shielded-sierra-8807.herokuapp.com to get the PIN and enter this in the app.
// 4. Once you've given the app permission to access your data, the web page will refresh and dislay your access token.
// 5. Set the accessToken string on line 25 in the Processing sketch.
// 6. Run the sketch.


// REQUIREMENTS
// Please make sure that you are using Processing 2.0 and have installed the ControlP5 GUI 2.0 library for this sketch to run properly.
// Processing 2.0 https://processing.org/download/
// ControlP5 2.0 Library http://www.sojamo.de/libraries/controlP5/


// CAVEATS
// If an incomplete day is cached and it's no longer the current day, the local file will not be refreshed. 
// Delete the file to force MovesMapper to query for a complete file.
// If you have not synced the app before running, it may fetch a malformed response that will cause the sketch to crash. If this happens, sync the app, delete the JSON data file and re-run the sketch.


// DEVELOPMENT CHANGELOG
// draw paths as lines
// make each day an object
// separate drawing and parsing into separate blocks
// scale viewport to fit data
// only draw markers & labels 1x
// color walk, cycle and run lines appropriately
// poll API directly for data
// look to local data before polling API
// GUI: months / days / years
// Convert caching logic into a function
// Don't rebuild Moves data structure every time a day is added (switch to hashmap)
// prevent out of bounds error when querying for days without data
// move map() computation out of draw() loop
// GUI: labels
// GUI: transportation type
// reset map scaling to fit data
// time of day slider for lines
// switch slider to minutes
// GUI: Start in ON state
// only show places after correct time
// implement time zone support (merged from https://github.com/yonoleo/MMapper)


// HIGH PRI
// preserve aspect ratio of map


// MID PRI
// steps / miles / etc display
// move labeling map function out of draw loop
// Requery the current day on launch?
// GUI: location blobs
// GUI: PDF export
// GUI: All On / All Off
// improve error handling of requests for days without data


// LOW PRI
// add basemap (use symbols?)
// add ability to pan and zoom map


// FIRST ACCOMPLISHMENTS
// first time using dictionary structures like StringDict and HashMap
// first time implementing live queries of an API
// first time using JSON objects

