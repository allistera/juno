# frozen_string_literal: true

Time::DATE_FORMATS[:custom_date] = ->(time) { time.strftime("#{time.day.ordinalize} of %b at %k:%M") }
