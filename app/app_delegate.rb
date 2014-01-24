class AppDelegate

  # This is the entry point for our application.  The "AppDelegate" class
  # is registered in the "Info.plist" to be the application delegate.
  # (see <http://www.rubymotion.com/developer-center/guides/project-management/>)
  # for more information about the Info.plist file, and how to modify it from
  # the Rakefile.
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # we *always* need a window object to place views in.  when using
    # storyboards, this window is created for us.
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # Here we'll create an instance of our controller.  In a professional app,
    # we would want to store the state of the application when it exits, and
    # restore that state here; so if the user has opened a certain view, or
    # scrolled to a location, we should bring them back to that state if
    # possible.
    # For this app, though, I'm sticking to the basics (and for lots of
    # applications you can get away with doing things this way)
    weather_controller = WeatherController.new

    # Later I'll add a 'detail' screen, and we can use a navigation controller
    # to go back and forth between the 'browse' and 'detail' screens.  For now,
    # our navigation controller just contains our browse screen
    nav_controller = UINavigationController.alloc.initWithRootViewController(weather_controller)
    nav_controller.navigationBar.tintColor = :black.uicolor

    # display our nav controller in the window
    @window.rootViewController = nav_controller
    # and make it the "key window".  This is pretty much just necessary
    # boilerplate at this point, but multiple windows can be important if you
    # were developing an app that included support for outputting to an Apple TV
    @window.makeKeyAndVisible
    true
  end

end
