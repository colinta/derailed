Let's dive into testing!  We want to test two things: that our controller
displays a `UIActivityIndicatorView` when data has not been loaded, and that it
displays weather data when the data has been loaded.

RubyMotion comes with MacBacon, which is a very RSpec-like way of writing tests.
The only hitch is that you'll need to know quite a bit about how iOS works in
order to write good integration tests for controllers, and it will be
*essential* to use separate classes for storage (don't conflate your controller
with network and database code!)

Check out `spec/main_spec.rb` for our new tests.
