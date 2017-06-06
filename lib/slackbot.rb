require 'slack-ruby-bot'
require_relative './darksky.rb'
require_relative './google_coordinates.rb'

class Slackbot < SlackRubyBot::Bot
  command 'weather now' do |client, data, match|
    location = match[:expression]
    if location.to_s.strip.blank?
      client.say(text: 'Getting weather for Washington DC...', channel: data.channel)
      location = 'Washington DC'
    end
    coordinates = GoogleCoordinates.location_info(location)
    if coordinates.is_a? String
      client.say(text: coordinates, channel: data.channel)
    else
      weather_now = Darksky.weather_now(coordinates)
    end
    client.say(text: weather_now, channel: data.channel)
    #todo: include the address name returned by Google in the message to the user in case of a different address than assumed, e.g. Springfield query returning Springfield MA
  end

  command 'weather tomorrow' do |client, data, match|
    #todo: DRY these functions up
    location = match[:expression]
    if location.to_s.strip.blank?
      client.say(text: 'Getting weather for Washington DC...', channel: data.channel)
      location = 'Washington DC'
    end
    coordinates = GoogleCoordinates.location_info(location)
    if coordinates.is_a? String
      client.say(text: coordinates, channel: data.channel)
    else
      weather_tomorrow = Darksky.weather_tomorrow(coordinates)
    end
    client.say(text: weather_tomorrow, channel: data.channel)
  end
end
