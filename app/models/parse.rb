module Parse

    def self.race_input_to_hash(file)
        laps = []
        pilots = []
        File.open(file.path).each do |line|
            info = line
                    .split(" ")
                    .select { |n| s = n.strip.downcase; s != "" && s != "–" }
            
            if !info.empty?

                lap = laps.detect{
                    |lap| 
                    lap[:lap_number] == info[3].to_i
                }

                if lap
                    lap_hash = lap
                else
                    lap_hash = {
                        lap_number: info[3].to_i,
                        lap_pilots: []
                    }
                    laps.push(lap_hash)
                end

                pilot_in_lap = lap_hash[:lap_pilots].detect {
                    |pilot|
                    pilot[:pilot_number] == info[1].to_i
                }

                if !pilot_in_lap
                    lap_hash[:lap_pilots].push({
                        pilot_number: info[1].to_i,
                        lap_created_at: "1990-01-01 00:#{info[0]}".to_datetime,
                        lap_time: "1990-01-01 00:#{info[4]}".to_datetime,
                        average_speed: to_standard_float(info[5])
                    })
                end

                pilot = pilots.detect {
                    |pilot|
                    pilot[:pilot_number] == info[1].to_i
                }

                if !pilot
                    pilots.push({
                        pilot_number: info[1].to_i,
                        name: info[2]
                    })
                end

            end
        end

        return {laps: laps, pilots: pilots}
    end

    private
    
    def self.to_standard_float(value)
        if value
            return value.to_s.gsub(/[,]/, '.').to_f
        end
        return 0
    end

end