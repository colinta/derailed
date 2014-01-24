class SpinnerCell < UITableViewCell
  ID = 'SpinnerCell'

  # provide access to our activity indicator, in case another object wants to
  # make changes to it
  attr :activity_indicator

  # initWithStyle(reuseIdentifier:) is the designated initializer for
  # `UITableViewCell`
  def initWithStyle(style, reuseIdentifier:identifier)
    super.tap do
      # don't show 'tap' animations for this cell
      self.selectionStyle = UITableViewCellSelectionStyleNone

      # use a 'gray' indicator
      @activity_indicator = UIActivityIndicatorView.gray
      # center it in our 'contentView'.  The 'contentView' is the view that
      # `UITableViewCell` provides to programmers to place custom subviews.
      # DON'T place views directly into the UITableViewCell (self) instance; the
      # behavior of doing so is not defined.
      @activity_indicator.center = self.contentView.center
      # the autoresizingMask determines how the view's frame is changed when its
      # superview's frame is changed.  In this case, we're using a SugarCube
      # constant to indicate that we want our view to "float"  relative to all
      # four sides of the parent frame.  In other words: stay fixed in the
      # middle of the view.
      @activity_indicator.autoresizingMask = :fixed_middle.uiautoresizemask
      self.contentView << @activity_indicator
      # We must animate the activity indicator; it is hidden by default.
      @activity_indicator.startAnimating
    end
  end

end
