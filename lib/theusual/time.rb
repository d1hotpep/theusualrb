class Time
  MINUTES_IN_THREE_QUARTERS_YEAR = 394200
  MINUTES_IN_QUARTER_YEAR = 131400
  MINUTES_IN_YEAR = 525600


  def self.at_ms ms
    # convert an integer representing Unix time in milliseconds
    ms ? Time.at(ms / 1_000.0).utc : nil
  end

  def to_ms
    # return the number of milliseconds since the Unix epoc
    (to_f * 1_000).to_i
  end

  # inspired by actionview/lib/action_view/helpers/date_helper.rb
  def humanize(to_time = nil, options = {})
    from_time = self.utc
    to_time ||= Time.now.utc
    from_time, to_time = to_time, from_time if from_time > to_time

    distance_in_minutes = ((to_time.to_i - from_time.to_i) / 60.0).to_i
    distance_in_seconds = (to_time.to_i - from_time.to_i).to_i

    res = case distance_in_minutes
    when 0
      if options[:seconds]
        case distance_in_seconds
          when 1      then [ :a_second ]
          when 2..4   then [ :less_than_x_seconds, 5 ]
          when 5..9   then [ :less_than_x_seconds, 10 ]
          when 10..29 then [ :less_than_x_seconds, 30 ]
          when 30..39 then [ :half_a_minute ]
          when 40..59 then [ :less_than_a_minute ]
          else             [ :a_minute ]
        end
      else
        if distance_in_seconds == 0
          [ :just_now ]
        else
          [ :less_than_a_minute ]
        end
      end
    when 1                then [ :a_minute ]
    when 2...45           then [ :x_minutes,      distance_in_minutes ]
    when 45...59          then [ :about_an_hour ]
    when 60               then [ :an_hour ]
    when 61...90          then [ :about_an_hour ]
    # 90 mins up to 24 hours
    when 90...1440        then [ :about_x_hours,  (distance_in_minutes.to_f / 60.0).round ]
    # 24 hours up to  hours
    when 1440...2160      then [ :a_day ]
    # 36 hours up to 30 days
    when 2160...43200     then [ :x_days,         (distance_in_minutes.to_f / 1440.0).round ]
    # 30 days up to 60 days
    when 43200...86400    then [ :about_x_months, (distance_in_minutes.to_f / 43200.0).round ]
    # 60 days up to 365 days
    when 86400...525600   then [ :x_months,       (distance_in_minutes.to_f / 43200.0).round ]
    else
      fyear = from_time.year
      fyear += 1 if from_time.month >= 3
      tyear = to_time.year
      tyear -= 1 if to_time.month < 3
      leap_years = (fyear > tyear) ? 0 : (fyear..tyear).count{|x| Date.leap?(x)}
      minute_offset_for_leap_year = leap_years * 1440
      # Discount the leap year days when calculating year distance.
      # e.g. if there are 20 leap year days between 2 dates having the same day
      # and month then the based on 365 days calculation
      # the distance in years will come out to over 80 years when in written
      # English it would read better as about 80 years.
      minutes_with_offset = distance_in_minutes - minute_offset_for_leap_year
      remainder                   = (minutes_with_offset % MINUTES_IN_YEAR)
      distance_in_years           = (minutes_with_offset.div MINUTES_IN_YEAR)
      if remainder < MINUTES_IN_QUARTER_YEAR
        [ :about_x_years,  distance_in_years ]
      elsif remainder < MINUTES_IN_THREE_QUARTERS_YEAR
        [ :over_x_years,   distance_in_years ]
      else
        [ :almost_x_years, distance_in_years + 1 ]
      end
    end

    if res.count > 1
      res.first.to_s.sub 'x', res.last.to_s
    else
      res.first.to_s
    end.gsub '_', ' '
  end

end
