require 'httparty'

class GoogleCoordinates
  attr_reader :coordinates, :description, :error

  def initialize(query)
    @queried_location = query
    populate_coordinates
  end

  def populate_coordinates
    @error = ''
    gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@queried_location}&key=#{ENV['MAPS_API_KEY']}"
    response = HTTParty.get(gmaps_url)
    case
    when response.code != 200
      @error = 'Sorry, there was an error completing your request.'
    when response['error_message']
      @error = response['error_message']
    when response['results'].count == 0
      @error = "Your query resulted in no matches. Please try again."
    when response['results'].count > 1
      @error = "Your query resulted in more than one match. Please try again."
    else
      @description = response['results'].first['formatted_address']
      location = response['results'].first['geometry']['location']
      @coordinates = [location['lat'], location['lng']].join(',')
    end
  end
end
