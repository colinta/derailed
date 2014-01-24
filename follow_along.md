To take this one step further, we should add a detail screen.  This will display
the date, summary, and temperature.

We'll add a method to our controller `display_weather(weather)`, and this method
will get called from the table module.  It will create a
`WeatherDetailController`, and push that controller onto our
`UINavigationController`.

The `WeatherDetailController` should have its own 'storage' mechanism, but since
we aren't going to do any fetching of data, we'll just pass it a `WeatherModel`
instance, which is another new addition in this commit.

Take a look at how I take the data from Firebase - which has an
'apparentTemperature' field, which *only* the `WeatherStorage` class knows is in
farenheit - and pass it to the `WeatherModel` class as `degrees_farenheit`.  If
Firebase changes, or if I change to another backend, I do not need to change my
model; it is ready to work in celsius OR farenheit.
