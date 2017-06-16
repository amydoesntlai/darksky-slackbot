require_relative '../lib/google_coordinates.rb'

describe "google coordinates functionality" do
  before do
    class Hash
      def code #hack to be able to fake HTTParty responses using hashes
        200
      end
    end
  end

  it "populates an error message if the api returns an error message" do
    allow(HTTParty).to receive(:get).and_return({'error_message' => 'API error'})
    location = GoogleCoordinates.new('gibberish')
    expect(location.error).to eq('API error')
    expect(location.coordinates).to be_nil
  end

  it "populates coordinates for 'Washington, DC'" do
    coords = '38.9071923,-77.0368707'
    allow(HTTParty).to receive(:get).and_return({'results' => [{'formatted_address' => 'Washington, DC, USA', 'geometry' => {'location' => {'lat' => 38.9071923, 'lng' => -77.0368707}}}]})
    location = GoogleCoordinates.new('Washington DC')
    expect(location.error).to eq('')
    expect(location.description).to eq('Washington, DC, USA')
    expect(location.coordinates).to eq(coords)
  end

  it "handles no location found" do
    allow(HTTParty).to receive(:get).and_return({'results' => []})
    location = GoogleCoordinates.new('Washington DC')
    expect(location.error).to eq("Your query resulted in no matches. Please try again.")
  end

  it "handles multiple locations found" do
    allow(HTTParty).to receive(:get).and_return({'results' => ['location1', 'location2']})
    location = GoogleCoordinates.new('Washington DC')
    expect(location.error).to eq("Your query resulted in more than one match. Please try again.")
  end

  it "populates an error if the request is unsuccessful" do
    class Hash
      def code
        'non-200'
      end
    end
    allow(HTTParty).to receive(:get).and_return(Hash.new)
    location = GoogleCoordinates.new('gibberish')
    expect(location.error).to eq('Sorry, there was an error completing your request.')
    expect(location.coordinates).to be_nil
  end
end
