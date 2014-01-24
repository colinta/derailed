class WeatherDetailController < UIViewController
  include WeatherDetailControllerLayout

  def initWithWeather(weather)
    # call our parent class' designated initializer
    init.tap do
      @weather = weather
    end
  end

  # we'll take a different approach to creating our view.  We'll use the
  # `viewDidLoad` method hook to add our custom subviews
  def viewDidLoad
    # but not here!  Let's use a layout module
    self.build_layout

    # we can focus on assigning the weather data to our views
    # we'll use the SugarCube helper to create our own date format
    self.date_label.text = @weather.time.string_with_format('EEEE, MMM d hh:mm')
    self.summary_label.text = @weather.summary
    self.temp_label.text = "#{@weather.degrees_farenheit.round(1)}°"
  end

  def viewWillAppear(animated)
    super

    delay = 0.1
    self.date_label.slide_from(:left, delay: 1 * delay)
    self.summary_label.slide_from(:right, delay: 2 * delay)
    self.temp_label.slide_from(:left, delay: 3 * delay)
  end

end
