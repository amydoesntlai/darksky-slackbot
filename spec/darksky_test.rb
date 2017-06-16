require_relative '../lib/darksky.rb'

describe "darksky functionality" do

  it "gets current weather" do
    class Hash
      def code #hack to be able to fake HTTParty responses using hashes
        200
      end
    end
    result = { 'currently' => { 'summary' => 'Light rain', 'temperature' => 65.8 } }
    allow(Darksky).to receive(:darksky_info).and_return(result)
    expect(Darksky.weather('now', [38.9071923, -77.0368707])).to eq('Light rain, 66 degrees')
  end

  it "returns an error message when failing to get current weather" do
    class Hash
      def code
        'non-200'
      end
    end
    allow(Darksky).to receive(:darksky_info).and_return({})
    expect(Darksky.weather('now', [38.9071923, -77.0368707])).to eq('Sorry, your request could not be completed.')
  end

  it "gets tomorrow's weather" do
    class Hash
      def code
        200
      end
    end
    tomorrow_summary = 'Light rain starting in the morning, continuing until afternoon.'
    result = { 'daily' => { 'data' => [{ 'summary' => tomorrow_summary }] } }
    allow(Darksky).to receive(:darksky_info).and_return(result)
    expect(Darksky.weather('tomorrow', [38.9071923, -77.0368707])).to eq(tomorrow_summary)
  end

  it "returns an error message when failing to get tomorrow's weather" do
    class Hash
      def code
        'non-200'
      end
    end
    allow(Darksky).to receive(:darksky_info).and_return({})
    expect(Darksky.weather('tomorrow', [38.9071923, -77.0368707])).to eq('Sorry, your request could not be completed.')
  end
end
