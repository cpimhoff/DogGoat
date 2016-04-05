
Time::DATE_FORMATS[:month_year] = "%B %Y"
Time::DATE_FORMATS[:month] = "%B"
Time::DATE_FORMATS[:day_month] = ""
Time::DATE_FORMATS[:short_ordinalized] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }
