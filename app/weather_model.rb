class WeatherModel
  attr :time
  attr :summary

  class << self

    def farenheit_to_celsius(farenheit)
      return 5.0 / 9.0 * (farenheit - 32)
    end

    def celsius_to_farenheit(celsius)
      return 9.0 / 5.0 * celsius + 32
    end

  end

  def initialize(opts={})
    @time = opts['time']
    @summary = opts['summary'].dup.freeze

    if opts['degrees_farenheit']
      @farenheit = opts['degrees_farenheit']
    elsif opts['degrees_celsius']
      @celsius = opts['degrees_celsius']
    else
      @farenheit = 0
      @celsius = 0
    end
  end

  def degrees_celsius
    @celsius || WeatherModel.farenheit_to_celsius(@farenheit)
  end

  def degrees_farenheit
    @farenheit || WeatherModel.celsius_to_farenheit(@celsius)
  end

end
