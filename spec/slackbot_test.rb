require_relative '../lib/slackbot.rb'
require 'slack-ruby-bot/rspec'

describe Slackbot do
  it "responds to the 'weather now' command with the current weather" do
    weather_now = 'Light rain, 66 degrees'
    allow(Darksky).to receive(:weather_now).and_return(weather_now)
    expect(message: "#{SlackRubyBot.config.user} weather now", channel: 'channel').to respond_with_slack_message(weather_now)
  end

  it "responds to the 'weather tomorrow' command with tomorrow's weather" do
    tomorrow_summary = 'Light rain starting in the morning, continuing until afternoon.'
    allow(Darksky).to receive(:weather_tomorrow).and_return(tomorrow_summary)
    expect(message: "#{SlackRubyBot.config.user} weather tomorrow", channel: 'channel').to respond_with_slack_message(tomorrow_summary)
  end
end
