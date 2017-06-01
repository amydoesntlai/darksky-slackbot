require 'httparty'

darksky_url = "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/38.9072,-77.0369"
response = HTTParty.get(darksky_url)
if response.code == 200
  current_summary = response['currently']['summary']
  current_temp = response['currently']['temperature']
  weather_tomorrow = response['daily']['data'].first['summary']
  puts current_summary
  puts current_temp
  puts weather_tomorrow
else
  puts "didn't work"
end
