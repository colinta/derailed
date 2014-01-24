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
