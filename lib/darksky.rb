require 'httparty'

class Darksky
  def self.darksky_info(coordinates)
    darksky_url = "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{coordinates}"
    return HTTParty.get(darksky_url)
  end

  def self.weather(timeframe, coordinates)
    info = darksky_info(coordinates)
    return "Sorry, your request could not be completed." if info.code != 200
    if timeframe == 'now'
      current_summary = info['currently']['summary']
      current_temp = info['currently']['temperature'].round(0)
      return "#{current_summary}, #{current_temp} degrees"
    elsif timeframe == 'tomorrow'
      #todo: make sure "tomorrow's weather" is weather for the next day, not 24 hours after the query time (e.g. asking for weather at 11pm would bring up weather starting in the morning, not 11pm the next night)
      return info['daily']['data'].first['summary']
    end
  end
end
