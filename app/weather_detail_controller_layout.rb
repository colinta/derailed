module WeatherDetailControllerLayout
  MARGIN_LEFT = 8
  MARGIN_TOP = 8

  def build_layout
    self.view.backgroundColor = :black.uicolor
    self.view << self.date_label
    self.view << self.summary_label
    self.view << self.temp_label
  end

  def date_label
    unless @date_label
      top = 64 + MARGIN_TOP
      @date_label = UILabel.alloc.initWithFrame([[MARGIN_LEFT, top], [304, 25]])
      @date_label.textAlignment = UITextAlignmentCenter
      @date_label.font = 'Avenir-Roman'.uifont(18)
      @date_label.textColor = :white.uicolor
    end
    return @date_label
  end

  def summary_label
    unless @summary_label
      top = CGRectGetMaxY(self.date_label.frame) + MARGIN_TOP
      @summary_label = UILabel.alloc.initWithFrame([[MARGIN_LEFT, top], [304, 28]])
      @summary_label.textAlignment = UITextAlignmentCenter
      @summary_label.font = 'Avenir-Roman'.uifont(20)
      @summary_label.textColor = :white.uicolor
    end
    return @summary_label
  end

  def temp_label
    unless @temp_label
      top = CGRectGetMaxY(self.summary_label.frame) + MARGIN_TOP
      @temp_label = UILabel.alloc.initWithFrame([[MARGIN_LEFT, top], [304, 41]])
      @temp_label.textAlignment = UITextAlignmentCenter
      @temp_label.font = 'Avenir-Roman'.uifont(30)
      @temp_label.textColor = :white.uicolor
    end
    return @temp_label
  end

end
