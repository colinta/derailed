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

  # this method is called from the Cocoa Touch framework when the view is
  # needed.  We are expected to assign a `UIView` instance to the `self.view`
  # property of our controller
  def loadView
    # the `frame` is a C-struct (a "boxed" c-struct, in RubyMotion terminology)
    # that has an `origin` and `size` property.  `origin` is a `CGPoint` (x, y
    # properties) and `size` is a `CGSize` (with `width`, `height`).  "CG"
    # stands for "CoreGraphics".

    # This value (`UIScreen.mainScreen.bounds`) is a sensible default when
    # you're dealing with a full-screen view controller.  It is possible to
    # write view controllers for a view that is only meant to cover a portion of
    # the screen, but in most cases you will want a full-screen view controller,
    # and so you can use this frame in those cases.  Actually, it is even MORE
    # common to ignore the `loadView` method altogether, and instead to place
    # your subviews in the default `self.view` instance that is created
    # automatically.
    self.view = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end

end
