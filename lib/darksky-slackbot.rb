require 'httparty'
require 'slack-ruby-bot'

class Darksky
  def self.darksky_info
    darksky_url = "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/38.9072,-77.0369"
    response = HTTParty.get(darksky_url)
    if response.code == 200
      return response
    else
      return "Sorry, your request could not be completed."
    end
  end

  def self.weather_now
    info = darksky_info
    if info.is_a? String
      return info
    end
    current_summary = info['currently']['summary']
    current_temp = info['currently']['temperature'].round(0)
    return "#{current_summary}, #{current_temp} degrees"
  end

  def self.weather_tomorrow
    info = darksky_info
    if info.is_a? String
      return info
    end
    return info['daily']['data'].first['summary']
  end
end

class Slackbot < SlackRubyBot::Bot
  command 'weather now' do |client, data, match|
    client.say(text: Darksky.weather_now, channel: data.channel)
  end

  command 'weather tomorrow' do |client, data, match|
    client.say(text: Darksky.weather_tomorrow, channel: data.channel)
  end
end
Slackbot.run
