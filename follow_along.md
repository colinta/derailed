Now let's take things up a notch by displaying some real data!  We'll be using
a real-time weather database that is provided by [Firebase][].  We're using the
[motion-firebase][] gem to access its API.

Lots more implementation code in this commit; at the end of the day all we are
doing is fetch the data, sort it, and update the table view.

[Firebase]: http://firebase.com
[motion-firebase]: https://github.com/colinta/motion-firebase
