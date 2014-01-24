# Our WeatherController will display a list of recent weather in Denver
class WeatherController < UIViewController
  # this module contains our view, dataSource, and delegate methods related to
  # the `UITableView`.
  include WeatherControllerTable

  # in testing, we'll assign a "fake" storage instance to this property
  attr_accessor :storage

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
      self.storage = WeatherStorage.new
    end
  end

  # this method is called from the Cocoa Touch framework when the view is
  # needed.  We are expected to assign a `UIView` instance to the `self.view`
  # property of our controller
  def loadView
    self.view = self.table_view
  end

  # when the `UINavigationController` is about to display our view, this method
  # will be called to notify us that our view is going to be added to the view
  # hierarchy.  We'll take this opportunity to start loading our weather data
  def viewWillAppear(animated)
    super  # this method is a UIViewController method, so be a good citizen and
           # notify the parent class.

    # tell our storage class we're ready for it to start generating data, and
    # what to do when new data is available
    self.storage.open do
      # we need to notify our table view that the data has changed
      self.table_view.reloadData
    end
  end

  # the complement to viewWillAppear, this method is called when a view is going
  # to be removed from the view hierarchy.
  def viewWillDisappear(animated)
    super
    # tell storage class to stop listening for new data
    self.storage.close
  end

end
