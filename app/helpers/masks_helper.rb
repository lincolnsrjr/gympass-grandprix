module MasksHelper
    
    def mask_time(value)
        value.strftime('%M:%S.%3N') if value
    end

    def mask_speed(value)
        value.round(3).to_s.gsub(/[.]/, ',') if value
    end
end