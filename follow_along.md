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
