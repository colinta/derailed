We've got our table loaded, now we're ready to take the next leap in our foray
into iOS development.  We'll assign our `WeatherController` as the `dataSource`
of the `UITableView`, which means our controller will be responsible for
implementing the methods in the [`UITableViewDataSource` protocol][UITableViewDataSource].

In our contrived example, we'll output the `NSIndexPath` object using the Ruby
method `inspect`, assigning that to the `textLabel` of the `UITableViewCell`.

[UITableViewDataSource]: https://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDataSource_Protocol/Reference/Reference.html
