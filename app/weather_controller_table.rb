module WeatherControllerTable

  def table_view
    unless @table_view
      @table_view = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      self.view.dataSource = self
      self.view.delegate = self
      self.view.registerClass(UITableViewCell, forCellReuseIdentifier: 'cell')
      self.view.registerClass(SpinnerCell, forCellReuseIdentifier: SpinnerCell::ID)
    end
    return @table_view
  end


  def tableView(table_view, numberOfRowsInSection: section)
    if self.storage.loaded?
      # each entry in storage gets a row in our table view
      self.storage.length
    else
      # data isn't ready yet, so display the spinner cell
      1
    end
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    if self.storage.loaded?
      # this method will always return an instance using the class we specified
      # above; it may be a new instance, it may be a reused cell.
      cell = table_view.dequeueReusableCellWithIdentifier('cell')
      # the stock UITableViewCell has a few labels where we can toss data.  We'll
      # use the `textLabel` view (an instance of `UILabel`).  The label has a
      # `text` property that we can assign a string to.

      # we'll construct a 'text' value based on the "timestamp" and "summary"
      # fields of our incoming data.  We use the `NSIndexPath` object to retrieve
      # the index of the row.
      weather_model = self.storage[index_path.row]
      text = ''  # start with a mutable string
      # add a short date and time
      text << weather_model.time.string_with_style(:short, :short)
      # and add the summary, with ": " between the date and summary
      text << ': ' << weather_model.summary

      cell.textLabel.text = text
    else
      cell = table_view.dequeueReusableCellWithIdentifier(SpinnerCell::ID)
    end

    return cell
  end

  # When the cell is selected, immediately deselect it.  If we add a
  # detail-view, we would push it onto our navigation controller here.
  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    table_view.deselectRowAtIndexPath(index_path, animated: true)

    if self.storage.loaded?
      weather_model = self.storage[index_path.row]
      self.display_weather(weather_model)
    end
  end

end
