MovesMapper
===========

A processing sketch for rendering location and activity data from the Moves iPhone app.


REQUIREMENTS
Make sure that you are using Processing 2.0 and have installed the ControlP5 GUI 2.0 library for this sketch to run properly.
Processing 2.0 https://processing.org/download/
ControlP5 2.0 Library http://www.sojamo.de/libraries/controlP5/


SETUP
1. Register an API client at: https://dev.moves-app.com
2. Get ClientID and ClientSecret
3. Request all access from the API:
    https://api.moves-app.com/oauth/v1/authorize?response_type=code&client_id= <insert ClientID> &scope=activity+location
4. Open Moves app. Go to Settings > Apps and select the "Enter PIN Code" option:
5. After entering the PIN correctly and approving the access request, the browser will redirect to a URL like:
    http://YourRedirectURL.com/?code= <CodeResponse> &state=
6. Request an access token by constructing the following request and pasting it into a terminal window:
    curl \-F 'client_id=<client_id>' \
    -F 'client_secret=<client_secret>' \
    -F 'grant_type=authorization_code' \
    -F 'redirect_uri=<redirect_uri>' \
    -F 'code=<code>' \https://api.moves-app.com/oauth/v1/access_token?
7. If everything is formed correctly and your request is made within 5 minutes of entering the PIN in the Moves app, the JSON response will contain your access token.
8. Set the accessToken string on line 25.
9. Run the sketch.


CAVEATS
If an incomplete day is cached and it's no longer the current day, the local file will not be refreshed. 
Delete the file to force MovesMapper to query for a complete file.
If you have not synced the app before running, it may fetch a malformed response that will cause the sketch to crash. 
If this happens, sync the app, delete the JSON data file and re-run the sketch.


