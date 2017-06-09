require 'slack-ruby-bot'
require_relative './darksky.rb'
require_relative './google_coordinates.rb'

class Slackbot < SlackRubyBot::Bot
  command 'weather now' do |client, data, match|
    location = match[:expression] || 'Washington DC'
    location_description, coordinates = GoogleCoordinates.location_info(location)
    if coordinates.blank?
      client.say(text: location_description, channel: data.channel)
    else
      weather_now = Darksky.weather_now(coordinates)
      client.say(text: "Weather now for #{location_description}: #{weather_now}", channel: data.channel)
    end
  end

  command 'weather tomorrow' do |client, data, match|
    #todo: DRY these functions up
    location = match[:expression] || 'Washington DC'
    location_description, coordinates = GoogleCoordinates.location_info(location)
    if coordinates.blank?
      client.say(text: location_description, channel: data.channel)
    else
      weather_tomorrow = Darksky.weather_tomorrow(coordinates)
      client.say(text: "Weather tomorrow for #{location_description}: #{weather_tomorrow}", channel: data.channel)
    end
  end
end
