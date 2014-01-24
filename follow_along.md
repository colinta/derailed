We would like to indicate to our users that the data is still loading.  For
this, we will add a `@loaded` ivar to our controller to track whether we have
received any data from Firebase yet.  If @loaded is false, we should display a
single `SpinnerCell`, which is a custom subclass of `UITableViewCell` with a
`UIActivityIndicatorView` (a "spinner" animation).
