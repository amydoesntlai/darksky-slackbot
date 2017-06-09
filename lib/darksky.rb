require 'httparty'

class Darksky
  def self.darksky_info(coordinates)
    darksky_url = "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/#{coordinates}"
    response = HTTParty.get(darksky_url)
    if response.code == 200
      return response
    else
      return "Sorry, your request could not be completed."
    end
  end

  def self.weather_now(coordinates)
    info = darksky_info(coordinates)
    if info.is_a? String
      return info
    end
    current_summary = info['currently']['summary']
    current_temp = info['currently']['temperature'].round(0)
    return "#{current_summary}, #{current_temp} degrees"
  end

  def self.weather_tomorrow(coordinates)
    #todo: DRY these functions up
    #todo: make sure "tomorrow's weather" is weather for the next day, not 24 hours after the query time (e.g. asking for weather at 11pm would bring up weather starting in the morning, not 11pm the next night)
    info = darksky_info(coordinates)
    if info.is_a? String
      return info
    end
    return info['daily']['data'].first['summary']
  end
end
