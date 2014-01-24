First we'll move our network code into its own class, `WeatherStorage`.  This
class will be responsible for opening and closing connections to Firebase, and
for storing the data that Firebase sends us.

It will accept a block that is called when the data changes.
