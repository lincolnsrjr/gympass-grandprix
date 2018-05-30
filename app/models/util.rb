module Util

    def self.new_time(value)
        splited = value.strftime('%M.%S.%3N').split('.')
        minutes_value = splited[0].to_i
        seconds_value = splited[1].to_i
        milliseconds_value = splited[2].to_i
        return Date.today.to_time + minutes_value.minutes + seconds_value.seconds + milliseconds_value/1000.0
    end

    def self.add_time(date, value)
        splited = value.strftime('%M.%S.%3N').split('.')
        minutes_value = splited[0].to_i
        seconds_value = splited[1].to_i
        milliseconds_value = splited[2].to_i
        return date + minutes_value.minutes + seconds_value.seconds + milliseconds_value/1000.0
    end

    def self.dec_time(date_initial, date_final)
        splited = date_initial.strftime('%M.%S.%3N').split('.')
        minutes_value = splited[0].to_i
        seconds_value = splited[1].to_i
        milliseconds_value = splited[2].to_i
        return date_final - minutes_value.minutes - seconds_value.seconds - milliseconds_value/1000.0
    end

end