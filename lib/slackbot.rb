require 'slack-ruby-bot'
require_relative './darksky.rb'

class Slackbot < SlackRubyBot::Bot
  command 'weather now' do |client, data, match|
    client.say(text: Darksky.weather_now, channel: data.channel)
  end

  command 'weather tomorrow' do |client, data, match|
    client.say(text: Darksky.weather_tomorrow, channel: data.channel)
  end
end
Slackbot.run
