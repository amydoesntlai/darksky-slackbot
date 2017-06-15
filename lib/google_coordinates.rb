require 'httparty'

class GoogleCoordinates
  def self.location_info(location)
    gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV['MAPS_API_KEY']}"
    response = HTTParty.get(gmaps_url)
    case
    when response.code != 200
      return "Sorry, there was an error completing your request."
    when response['error_message']
      return response['error_message']
    when response['results'].count == 0
      return "Your query resulted in no matches. Please try again."
    when response['results'].count > 1
      return "Your query resulted in more than one match. Please try again."
    else
      description = response['results'].first['formatted_address']
      coords = response['results'].first['geometry']['location']
      return [description, "#{coords['lat']},#{coords['lng']}"]
    end
  end
end
