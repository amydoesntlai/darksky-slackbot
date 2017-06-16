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
    query_location = match[:expression] || 'Washington DC'
    location = GoogleCoordinates.new(query_location)
    if location.coordinates.nil?
      location.error
    else
      weather = Darksky.weather(timeframe, location.coordinates)
      "Weather #{timeframe} for #{location.description}: #{weather}"
    end
  end
end
