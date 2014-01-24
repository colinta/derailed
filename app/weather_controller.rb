# Our WeatherController will display a list of recent weather in Denver
class WeatherController < UIViewController

  # This is a publically accessible data source for weather data, and it's
  # updated in real-time (we could easily have the app track and display these
  # real-time updates).  `WEATHER` stores the URL, and `FIREBASE` is our
  # connection to the Firebase API.
  WEATHER = 'https://publicdata-weather.firebaseio.com'
  FIREBASE = Firebase.new(WEATHER)

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
      # We want to access the "denver hourly data" endpoint, so we create a
      # 'child' reference.
      @firebase_ref = FIREBASE.child('denver/hourly/data')
      # we'll store incoming data in this array
      @weather_data = []
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

  # when the `UINavigationController` is about to display our view, this method
  # will be called to notify us that our view is going to be added to the view
  # hierarchy.  We'll take this opportunity to start loading our weather data
  def viewWillAppear(animated)
    super  # this method is a UIViewController method, so be a good citizen and
           # notify the parent class.

    # the :child_added event occurs once for every child node of
    # denver/hourly/data.  'added' is somewhat misleading here; it's 'added' in
    # the sense that we have not *locally* seen this data.  Weather the node was
    # 'added' to Firebase recently or not is unknown, only that it's new to *our
    # app*
    @firebase_ref.on(:child_added) do |snapshot|
      # `ap` is short for `awesome-print`, a very handy gem that provides
      # colored output for Ruby objects.
      ap snapshot.value
      @weather_data << snapshot.value
      # data comes in unsorted, we need to fix that; we'll use the timestamp
      # to provide an easy sorting mechanism
      @weather_data.sort! { |a, b| a['time'] <=> b['time'] }
      # we need to notify our table view that the data has changed
      self.view.reloadData
    end
  end

  # the complement to viewWillAppear, this method is called when a view is going
  # to be removed from the view hierarchy.
  def viewWillDisappear(animated)
    super
    # turn off our network resource
    @ref.off
  end

  def tableView(table_view, numberOfRowsInSection: section)
    # each entry in @weather_data gets a row in our table view
    @weather_data.length
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    # this method will always return an instance using the class we specified
    # above; it may be a new instance, it may be a reused cell.
    cell = table_view.dequeueReusableCellWithIdentifier('cell')
    # the stock UITableViewCell has a few labels where we can toss data.  We'll
    # use the `textLabel` view (an instance of `UILabel`).  The label has a
    # `text` property that we can assign a string to.

    # we'll construct a 'text' value based on the "timestamp" and "summary"
    # fields of our incoming data.  We use the `NSIndexPath` object to retrieve
    # the index of the row.
    data = @weather_data[index_path.row]
    text = ''  # start with a mutable string
    # add a short date and time
    text << Time.at(data['time']).string_with_style(:short, :short)
    # and add the summary, with ": " between the date and summary
    text << ': ' << data['summary']

    cell.textLabel.text = text

    return cell
  end

end
