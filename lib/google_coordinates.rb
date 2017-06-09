require 'httparty'

class GoogleCoordinates
  def self.location_info(location)
    gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV['MAPS_API_KEY']}"
    response = HTTParty.get(gmaps_url)
    if response.code == 200
      if response['error_message']
        return response['error_message']
      elsif response['results'].count == 1
        description = response['results'].first['formatted_address']
        coords = response['results'].first['geometry']['location']
        return [description, "#{coords['lat']},#{coords['lng']}"]
      elsif response['results'].count > 1
        return "Your query resulted in more than one match. Please try again."
      else
        return "Your query resulted in no matches. Please try again."
      end
    else
      return "Sorry, there was an error completing your request."
      #todo: return custom errors instead of error strings
      #too brittle to branch on whether the return value is a string
    end
  end
end
