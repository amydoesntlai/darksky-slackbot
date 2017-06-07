# darksky-slackbot
This is an application that allows a bot to provide weather information when asked on Slack.

The bot responds to two arguments: "weather now" and "weather tomorrow". The default behavior is to give weather information for Washington DC, but it does look up weather for a different location if provided as an option, e.g. "weather now miami" or "weather tomorrow houston".

This app requires three environment variables to be set:
DARKSKY_API_KEY (Dark Sky API key),
MAPS_API_KEY (Google Maps API key), and
SLACK_API_TOKEN (Slack API key)

To run the app, call:
$ruby lib/darksky-slackbot.rb

This app is <a href="https://darksky.net/poweredby/">powered by Dark Sky</a>.
