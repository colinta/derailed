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

    # The `UITableView` will ask its `dataSource` for information related to the
    # data that this table view is displaying.  Google `UITableViewDataSource`
    # to see all the methods you can implement.  At a minimum, you must
    # implement `tableView(numberOfRowsInSection:) and
    # tableView(cellForRowAtIndexPath:)`.
    self.view.dataSource = self
    # cell reuse is a memory-management technique that Apple loves to rely on.
    # The table view will only create and use enough cells to fill the screen.
    # After that, it will reuse those cells so that memory does not need to be
    # allocated for more cells.  This means that you will be getting the *same
    # instance* of the cell over and over, so you have to be careful to
    # completely reset its state (touch handlers, view content, etc).
    # In practice, you should use a custom UITableViewCell subclass, and
    # implement the method `prepareForReuse` to reset the cell values.
    self.view.registerClass(UITableViewCell, forCellReuseIdentifier: 'cell')
  end

  def tableView(table_view, numberOfRowsInSection: section)
    # this is just a made up number - change it to 500 if you want to scroll
    # through lots of data (and use SugarCube's `tree` command to introspect
    # those cells!)
    5
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    # this method will always return an instance using the class we specified
    # above; it may be a new instance, it may be a reused cell.
    cell = table_view.dequeueReusableCellWithIdentifier('cell')
    # the stock UITableViewCell has a few labels where we can toss data.  We'll
    # use the `textLabel` view (an instance of `UILabel`).  The label has a
    # `text` property that we can assign a string to.
    cell.textLabel.text = index_path.inspect

    return cell
  end

end
