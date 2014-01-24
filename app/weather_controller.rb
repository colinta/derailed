# Our WeatherController will display a list of recent weather in Denver
class WeatherController < UIViewController

  # the `init` method is the Objective-C equivalent of Ruby's `initialize`
  # method.  Because WeatherController is a subclass of an Objective-C class, we
  # will use it's "designated initializer" (google it).  If we were writing a
  # "pure Ruby" class, we could use `def initialize` instead.
  def init
    # the `init` method *must* return self.  This is an implementation detail
    # of Objective-C.  My habit is to use this `super.tap` block so that self
    # is returned.  This style is getting popular in the RubyMotion community.
    super.tap do
      self.title = 'Denver Weather'
    end
  end

end
