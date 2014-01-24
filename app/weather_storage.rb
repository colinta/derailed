class WeatherStorage

  # This is a publically accessible data source for weather data, and it's
  # updated in real-time (we could easily have the app track and display these
  # real-time updates).  `WEATHER` stores the URL, and `FIREBASE` is our
  # connection to the Firebase API.
  WEATHER = 'https://publicdata-weather.firebaseio.com'
  FIREBASE = Firebase.new(WEATHER)

  # Since this is a "vanilla"/"pure" Ruby class, we can use the usual Ruby
  # constructor method
  def initialize
    # We want to access the "denver hourly data" endpoint, so we create a
    # 'child' reference.
    @firebase_ref = FIREBASE.child('denver/hourly/data')
    # we'll store incoming data in this array
    @weather_data = []
    # while data is loading, we should display a 'SpinnerCell'
    @loaded = false
  end

  def open(&handler)
    # the :child_added event occurs once for every child node of
    # denver/hourly/data.  'added' is somewhat misleading here; it's 'added' in
    # the sense that we have not *locally* seen this data.  Weather the node was
    # 'added' to Firebase recently or not is unknown, only that it's new to *our
    # app*
    @firebase_ref.on(:child_added) do |snapshot|
      @loaded = true
      @weather_data << snapshot.value
      # data comes in unsorted, we need to fix that; we'll use the timestamp
      # to provide an easy sorting mechanism
      @weather_data.sort! { |a, b| a['time'] <=> b['time'] }

      handler.call if handler
    end
  end

  def close
    @firebase_ref.off
  end

  def loaded?
    @loaded
  end

  def [](row)
    @weather_data[row]
  end

  def length
    @weather_data.length
  end

end
