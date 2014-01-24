See [follow_along][] for the current commit summary.  This file contains all the
'follow_along' entries.

[follow_along]: github.com/colinta/derailed/blob/master/follow_along.md

b1bb956
-------

Let's get back to organizing our controller.  I'm going to move the 'table view'
methods into their own module (`WeatherControllerTable`), so that we can slim
our controller, and have a "go-to" file when we need to make changes to the
table.

We could take another tack, which would be to create a custom
'WeatherDataSource' class to handle the table view methods, but I'll tell you
why I don't usually take that approach (note: *"usually"* means that sometimes
you *should* take this approach!).

The table view data source and delegate are working closely with elements of my
controller, so it is inevitable that they will need to hold onto a reference to
either the storage (so that the data source can introspect the data), or to the
controller (so that it can notify the controller of some events).  So yeah we
would slim up the controller a little, but we'd end up with a spaghetti of logic
to deal with the communication between the data source and the controller.

A module, though, provides the code separation we want without adding another
class, so minimizes that complexity.  Win!

I'm also going to create a method that creates our table view.  The reasoning
here is (a) it can be moved into our `WeatherControllerTable` module, and
(b) if we wanted to reorganize our view hierarchy, we could easily make the
table view a subview of another view.


d4bd6ad
-------

Let's dive into testing!  We want to test two things: that our controller
displays a `UIActivityIndicatorView` when data has not been loaded, and that it
displays weather data when the data has been loaded.

RubyMotion comes with MacBacon, which is a very RSpec-like way of writing tests.
The only hitch is that you'll need to know quite a bit about how iOS works in
order to write good integration tests for controllers, and it will be
*essential* to use separate classes for storage (don't conflate your controller
with network and database code!)

Check out `spec/main_spec.rb` for our new tests.


8986fc9
-------

First we'll move our network code into its own class, `WeatherStorage`.  This
class will be responsible for opening and closing connections to Firebase, and
for storing the data that Firebase sends us.

It will accept a block that is called when the data changes.


5d9ccfd
-------

Let's stop and take a look at our app, and see if we can improve its
organization.

Right now, ALL of our application logic is in one class, the
`WeatherController`.  This is no good!  Here are all the things that are wrapped
up in our `WeatherController` code:

- our decision to use Firebase as the backend
- storing Firebase data in an ordered array
- the view hierarchy
- the methods that link our table to our data

And on top of that, imagine writing tests for our controller.  We would need to
trick Firebase into NOT loading data, and then only loading data when we wanted
to test that portion of the app.

Instead, we should think of how we could do the following:

- move our network code into a separate class (so that we could replace it with
  a "fake" storage class during testing)
- try and separate our table code into another file, just so we don't have to
  look at it all the time when we are working in our controller
- write a test to make sure our controller works when we make changes in the
  future

We'll tackle these problems in the next few commits.


df965e2
-------

We would like to indicate to our users that the data is still loading.  For
this, we will add a `@loaded` ivar to our controller to track whether we have
received any data from Firebase yet.  If @loaded is false, we should display a
single `SpinnerCell`, which is a custom subclass of `UITableViewCell` with a
`UIActivityIndicatorView` (a "spinner" animation).


cbea1e8
-------

A quick commit, this introduces the [`UITableViewDelegate`][UITableViewDelegate].
We implement just one method from this protocol, the
`tableView(didSelectRowAtIndexPath:)` method.  In this method we can deselect
our cell (this doesn't happen automatically).

Data sources and delegates are essential to iOS and OS X development, so please
read up on why/how these work.

### Too Much Information

There are also memory considerations to consider here: the table view is
retained by the controller, so if the data source (our controller) was retained
by the table view, we would have a circular reference!  For this reason, data
sources and delegates are 'weak' references.  This doesn't matter in our little
app, but if we were using some *other* class as our data source, we would need
to make sure to hold onto that instance in our controller via an ivar.

[UITableViewDelegate]: https://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDelegate_Protocol/Reference/Reference.html


8219057
-------

Now let's take things up a notch by displaying some real data!  We'll be using
a real-time weather database that is provided by [Firebase][].  We're using the
[motion-firebase][] gem to access its API.

Lots more implementation code in this commit; at the end of the day all we are
doing is fetch the data, sort it, and update the table view.

[Firebase]: http://firebase.com
[motion-firebase]: https://github.com/colinta/motion-firebase


0ce69d0
-------
We've got our table loaded, now we're ready to take the next leap in our foray
into iOS development.  We'll assign our `WeatherController` as the `dataSource`
of the `UITableView`, which means our controller will be responsible for
implementing the methods in the [`UITableViewDataSource` protocol][UITableViewDataSource].

In our contrived example, we'll output the `NSIndexPath` object using the Ruby
method `inspect`, assigning that to the `textLabel` of the `UITableViewCell`.

[UITableViewDataSource]: https://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html


40a9a2c
-------
Our WeatherController is currently using a stock `UIView` as its root view.  To
make things interesting, let's see what happens if we use a `UITableView`
instead.  We're not going to configure our table view at all, just an
off-the-shelf `UITableView` instance.

Some things to notice: it's already got line separators between rows, it's
scrollable, and it fills the entire view port (if you look closely it actually
slides *under* the navigation bar, which is just a tiny bit transparent).

We are using the `loadView` hook to assign the `UITableView` to the `view`
property.

Since we're using the SugarCube gem, you could take this time to start playing
with its view introspection methods.  From the REPL, run `tree` to see the
view hierarchy.  To select a view to play with, use the `adjust` method, and
hand it the index (listed on the left) of the view.  After you call that method,
the view will be returned from the `adjust` method.  The `adjust` method is
aliased to `a` for quick usage.  For instance:

```
(main)> tree
  0: . UIWindow(#9bea670, [[0.0, 0.0], [320.0, 568.0]])
  1: `-- UILayoutContainerView(#9968f80, [[0.0, 0.0], [320.0, 568.0]])
  2:     +-- UINavigationTransitionView(#99712e0, [[0.0, 0.0], [320.0, 568.0]])
  3:     |   `-- UIViewControllerWrapperView(#96a49b0, [[0.0, 0.0], [320.0, 568.0]])
  4:     |       `-- UITableView(#a089c00, [[0.0, 0.0], [320.0, 568.0]])
  5:     |           +-- UITableViewWrapperView(#9bfa4c0, [[0.0, 0.0], [320.0, 568.0]])
  6:     |           +-- _UITableViewCellSeparatorView(#9b016a0, [[15.0, 43.5], [305.0, 0.5]])
...
 26:     |           +-- UIImageView(#965b7f0, [[316.5, -64.0], [3.5, 504.0]])
 27:     |           `-- UIImageView(#96c3b30, [[313.0, 500.5], [7.0, 3.5]])
 28:     `-- UINavigationBar(#9969230, [[0.0, 20.0], [320.0, 44.0]])
 29:         +-- _UINavigationBarBackground(#996b260, [[0.0, -20.0], [320.0, 64.0]])
 30:         |   +-- _UIBackdropView(#996c840, [[0.0, 0.0], [320.0, 64.0]])
 31:         |   |   +-- _UIBackdropEffectView(#996eed0, [[0.0, 0.0], [320.0, 64.0]])
 32:         |   |   `-- UIView(#996fa20, [[0.0, 0.0], [320.0, 64.0]])
 33:         |   `-- UIImageView(#996b5a0, [[0.0, 64.0], [320.0, 0.5]])
 34:         +-- UINavigationItemView(#9bef270, [[97.0, 8.0], [126.5, 27.0]])
 35:         |   `-- UILabel(#9bf0130, [[0.0, 3.0], [126.5, 22.0]], text: "Denver Weather")
 36:         `-- _UINavigationBarBackIndicatorView(#9975d50, [[8.0, 12.0], [12.5, 20.5]])

=> UIWindow(#9bea670, [[0.0, 0.0], [320.0, 568.0]])
(main)> a 28
=> UINavigationBar(#9969230, [[0.0, 20.0], [320.0, 44.0]]), child of UILayoutContainerView(#9968f80)
(main)> a.barTintColor = UIColor.greenColor
=> UIColor.greenColor
(main)> quit  # to terminate the app
```

This REPL introspection ability is CRUCIAL to your success as a RubyMotion
developer!  Learn it, use it, love it. :-)


d3311fb
-------
In our initial commit we only had the default, bare-bones application that is
generated when you use the `motion create derailed` command to start a new
application.

It gave us a Gemfile, Rakefile, AppDelegate, and a basic spec file to get
started.

In this commit, we've added a `UIWindow` - this is a necessary root view object.
I recommend having a snippet of `UIWindow`-creation code handy for when you start
new projects.

A `UIWindow` expects to be assigned a `rootViewController`, and we're going to use
a `UINavigationController`.  Inside that controller, we place an instance of our
`WeatherController`.

The `WeatherController` at this point just assigns itself a title, and we see
that title at the top, thanks to the navigation bar provided by the
`UINavigationController`.
