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
