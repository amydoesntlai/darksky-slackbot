require_relative '../lib/darksky.rb'
require 'rspec'

describe "darksky functionality" do
  it "gets current weather" do
    result = { 'currently' => { 'summary' => 'Light rain', 'temperature' => 65.8 } }
    allow(Darksky).to receive(:darksky_info).and_return(result)
    #better to mock HTTParty, haven't been able to get that to work yet
    expect(Darksky.weather_now([38.9071923, -77.0368707])).to eq('Light rain, 66 degrees')
  end

  it "returns an error message when failing to get current weather" do
    error_msg = "Sorry, your request could not be completed."
    allow(Darksky).to receive(:darksky_info).and_return(error_msg)
    #better to mock HTTParty, haven't been able to get that to work yet
    expect(Darksky.weather_now([38.9071923, -77.0368707])).to eq(error_msg)
  end

  it "gets tomorrow's weather" do
    tomorrow_summary = 'Light rain starting in the morning, continuing until afternoon.'
    result = { 'daily' => { 'data' => [{ 'summary' => tomorrow_summary }] } }
    allow(Darksky).to receive(:darksky_info).and_return(result)
    #better to mock HTTParty, haven't been able to get that to work yet
    expect(Darksky.weather_tomorrow([38.9071923, -77.0368707])).to eq(tomorrow_summary)
  end

  it "returns an error message when failing to get tomorrow's weather" do
    error_msg = "Sorry, your request could not be completed."
    allow(Darksky).to receive(:darksky_info).and_return(error_msg)
    #better to mock HTTParty, haven't been able to get that to work yet
    expect(Darksky.weather_tomorrow([38.9071923, -77.0368707])).to eq(error_msg)
  end
end
