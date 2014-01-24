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