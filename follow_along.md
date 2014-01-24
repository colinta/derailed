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
