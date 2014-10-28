MovesMapper
===========

A processing sketch for rendering location and activity data from the Moves iPhone or Android app.


## Requirements
Make sure that you are using Processing 2.0 and have installed the ControlP5 GUI 2.0 library for this sketch to run properly.
* Processing 2.0 `https://processing.org/download/`
* ControlP5 2.0 Library `http://www.sojamo.de/libraries/controlP5/`


## Setup
1. Open Moves app and make sure that your activity is up to date.
1. In the settings, go to the Apps section and click the add a PIN button.
1. Visit http://shielded-sierra-8807.herokuapp.com to get the PIN and enter this in the app.
1. Once you've given the app permission to access your data, the web page will refresh and display your access token.
1. Set the accessToken string in config.pde.
1. Run the sketch.


## Caveats
* If an incomplete day is cached and it's no longer the current day, the local file will not be refreshed. Delete the file to force MovesMapper to query for a complete file.
* If you have not synced the app before running, it may fetch a malformed response that will cause the sketch to crash. If this happens, sync the app, delete the JSON data file and re-run the sketch.


