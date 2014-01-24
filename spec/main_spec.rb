# We only need this class for these tests, so I'm just gonna toss it in here. If
# I needed it for other specs, I would put it in a helpers/ folder, or something
# like that
class FakeWeatherStorage < WeatherStorage

  def initialize
    super
    @weather_data = [{ 'time' => 1234567890, 'summary' => 'Great weather' }]
  end

  def open(&handler)
    @handler = handler
  end

  def close
  end

  def fake_load!
    @loaded = true
    @handler.call
  end

end


describe WeatherController do
  before do
    @controller = WeatherController.new
    @controller.storage = FakeWeatherStorage.new
  end

  # we must initialize @controller before we call this method if we want to do
  # any custom initialization.
  tests WeatherController

  it "displays a spinner when data has not been loaded" do
    spinners = views(UIActivityIndicatorView)
    spinners.should.not == []
    spinners.length.should == 1
  end

  it "displays weather data when data has been loaded" do
    @controller.storage.fake_load!
    labels = views(UILabel)
    weather_label = labels.find { |lbl| lbl.text =~ /Great weather/ }
    weather_label.should.not == nil
  end

end
