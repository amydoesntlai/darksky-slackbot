require_relative '../lib/slackbot.rb'
require 'slack-ruby-bot/rspec'

describe Slackbot do
  before do
    location = 'Washington, DC'
    coords_str = '38.9071923,-77.0368707'
    allow_any_instance_of(GoogleCoordinates).to receive(:populate_coordinates).and_return(nil)
    allow_any_instance_of(GoogleCoordinates).to receive(:coordinates).and_return(coords_str)
    allow_any_instance_of(GoogleCoordinates).to receive(:description).and_return('Washington, DC, USA')
    @weather_now = 'Light rain, 66 degrees'
    allow(Darksky).to receive(:weather).with('now', coords_str).and_return(@weather_now)

    @tomorrow_summary = 'Light rain starting in the morning, continuing until afternoon.'
    allow(Darksky).to receive(:weather).with('tomorrow', coords_str).and_return(@tomorrow_summary)
  end

  it "responds to the 'weather now' command with the current weather" do
    expect(message: "#{SlackRubyBot.config.user} weather now washington dc", channel: 'channel').to respond_with_slack_message("Weather now for Washington, DC, USA: #{@weather_now}")
  end

  it "responds to the 'weather now' command with the current weather in DC when no location is given" do
    expect(message: "#{SlackRubyBot.config.user} weather now", channel: 'channel').to respond_with_slack_message("Weather now for Washington, DC, USA: #{@weather_now}")
  end

  it "responds to the 'weather tomorrow' command with tomorrow's weather" do
    expect(message: "#{SlackRubyBot.config.user} weather tomorrow washington dc", channel: 'channel').to respond_with_slack_message("Weather tomorrow for Washington, DC, USA: #{@tomorrow_summary}")
  end

  it "responds to the 'weather tomorrow' command with tomorrow's weather in DC when no location is given" do
    expect(message: "#{SlackRubyBot.config.user} weather tomorrow", channel: 'channel').to respond_with_slack_message("Weather tomorrow for Washington, DC, USA: #{@tomorrow_summary}")
  end
end
