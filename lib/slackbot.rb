require 'slack-ruby-bot'
require_relative './darksky.rb'
require_relative './google_coordinates.rb'

class Slackbot < SlackRubyBot::Bot
  command 'weather now' do |client, data, match|
    client.say(text: bot_response('now', match), channel: data.channel)
  end

  command 'weather tomorrow' do |client, data, match|
    client.say(text: bot_response('tomorrow', match), channel: data.channel)
  end

  def self.bot_response(timeframe, match)
    location = match[:expression] || 'Washington DC'
    location_description, coordinates = GoogleCoordinates.location_info(location)
    if coordinates.blank?
      # location_description will be an error message string in this scenario
      return location_description
    else
      weather = Darksky.weather(timeframe, coordinates)
      return "Weather #{timeframe} for #{location_description}: #{weather}"
    end
  end
end
