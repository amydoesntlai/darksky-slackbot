require_relative '../lib/slackbot.rb'
require_relative '../lib/google_coordinates.rb'
require 'slack-ruby-bot/rspec'

describe Slackbot do
  it "responds to the 'weather now' command with the current weather" do
    weather_now = 'Light rain, 66 degrees'
    allow(Darksky).to receive(:weather_now).and_return(weather_now)
    location_info = ['Washington, DC', '38.9071923,-77.0368707']
    allow(GoogleCoordinates).to receive(:location_info).and_return(location_info)
    expect(message: "#{SlackRubyBot.config.user} weather now washington dc", channel: 'channel').to respond_with_slack_message("Weather now for Washington, DC: #{weather_now}")
  end

  it "responds to the 'weather tomorrow' command with tomorrow's weather" do
    tomorrow_summary = 'Light rain starting in the morning, continuing until afternoon.'
    allow(Darksky).to receive(:weather_tomorrow).and_return(tomorrow_summary)
    location_info = ['Washington, DC', '38.9071923,-77.0368707']
    allow(GoogleCoordinates).to receive(:location_info).and_return(location_info)
    expect(message: "#{SlackRubyBot.config.user} weather tomorrow washington dc", channel: 'channel').to respond_with_slack_message("Weather tomorrow for Washington, DC: #{tomorrow_summary}")
  end
end
