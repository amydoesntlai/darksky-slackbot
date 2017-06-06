require_relative '../lib/google_coordinates.rb'

describe "google coordinates functionality" do
  # better tests would mock the API call
  # todo: add tests for failed API call
  it "returns the correct coordinates for 'Washington, DC'" do
    expect(GoogleCoordinates.location_info('Washington, DC')).to eq([38.9071923, -77.0368707])
  end

  it "returns the correct coordinates for 'los angeles'" do
    expect(GoogleCoordinates.location_info('los angeles')).to eq([34.0522342, -118.2436849])
  end

  it "handles no location found" do
    expect(GoogleCoordinates.location_info('abcdefghijk')).to eq("Your query resulted in no matches. Please try again.")
  end
end
