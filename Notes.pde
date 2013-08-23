
// SETUP
// 1. Register an API client at: https://dev.moves-app.com
// 2. Get ClientID and ClientSecret
// 3. Request all access from the API:
//    https://api.moves-app.com/oauth/v1/authorize?response_type=code&client_id= <insert ClientID> &scope=activity+location
// 4. Open Moves app. Go to Settings > Apps and select the "Enter PIN Code" option:
// 5. After entering the PIN correctly and approving the access request, the browser will redirect to a URL like:
//    http://YourRedirectURL.com/?code= <CodeResponse> &state=
// 5. Request an access token by constructing the following request and pasting it into a terminal window:
//    curl \-F 'client_id=<client_id>' \
//    -F 'client_secret=<client_secret>' \
//    -F 'grant_type=authorization_code' \
//    -F 'redirect_uri=<redirect_uri>' \
//    -F 'code=<code>' \https://api.moves-app.com/oauth/v1/access_token?
// 6. If everything is formed correctly and your request is made within 5 minutes of entering the PIN in the Moves app, the JSON response will contain your access token.
// 7. Set the accessToken string on line 25.
// 8. Run the sketch.


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


// HIGH PRI
// preserve aspect ratio of map
// implement time zone offset


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

