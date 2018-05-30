class Race < ApplicationRecord

    has_many :laps, dependent: :restrict_with_error 
    
    validates :name, presence: true

    def self.add(laps_hash, pilots_hash)
        
        if laps_hash.empty?
            raise NotAcceptableException.new(I18n.t(:laps_invalid))
        end

        if pilots_hash.empty?
            raise NotAcceptableException.new(I18n.t(:pilots_invalid))
        end

        race = Race.new(
            name: Faker.grandprix
        )

        if !race.save
            raise NotAcceptableException.new(race.errors.full_messages)
        end

        Lap.add_laps(laps_hash, race, Pilot.add_pilots(pilots_hash).map {|item| 
            {
                name: item.name,
                pilot_number: item.pilot_number,
                last_lap: 0,
                id: item.id
            }
        })

        return race
    end

    def self.index
        return Race.select('id, name').order("id desc")
    end

    def self.info(id)
        
        if !id
            NotAcceptableException.new(nil, nil, I18n.t("race_not_found"))
        end

        race = Race.find_by(id: id)

        if !race
            NotAcceptableException.new(nil, nil, I18n.t("race_not_found"))
        end
        
        laps = Lap.where(race_id: race.id).order('lap_number')

        best_lap = nil
        best_lap_time = nil
        best_lap_pilot = nil

        pilots = Pilot
                    .where(
                        "id in (
                            select pilot_id
                            from lap_pilots
                            join laps
                                on lap_pilots.lap_id = laps.id
                            where laps.race_id = ?   
                        )",
                        race.id
                    )
        
        pilot_results = []
        pilot_positions = []
        pilot_positions_dont_finished = []
        laps.each do |lap|

            lap_pilots = LapPilot.includes(:pilot).where(lap_id: lap.id).order(:lap_created_at)

            

            lap_pilots.each_with_index do |lap_pilot, index|

                pilot = pilots.detect {
                    |old_pilot|
                    old_pilot.id == lap_pilot.pilot_id
                }

                if best_lap_time == nil || best_lap_time > lap_pilot.lap_time
                    best_lap = lap.lap_number
                    best_lap_time = lap_pilot.lap_time
                    best_lap_pilot = pilot.full_info
                end

                pilot_result = pilot_results.detect {
                    |old_pilot_result|
                    old_pilot_result[:pilot_number] == pilot.pilot_number
                } 

                if !pilot_result
                    
                    pilot_result = {
                        pilot_number: pilot.pilot_number,
                        name: pilot.name,
                        atual_lap: lap.lap_number,
                        atual_lap_time: lap_pilot.lap_created_at,
                        total_time: Util.new_time(lap_pilot.lap_time),
                        best_lap_number: lap.lap_number,
                        best_lap_time: lap_pilot.lap_time,
                        average_speed: lap_pilot.average_speed
                    }

                    pilot_results.push(pilot_result)

                else

                    pilot_result[:atual_lap] = lap.lap_number
                    pilot_result[:atual_lap_time] = lap_pilot.lap_created_at
                    pilot_result[:total_time] = Util.add_time(pilot_result[:total_time], lap_pilot.lap_time)

                    if lap_pilot.lap_time < pilot_result[:best_lap_time]
                        pilot_result[:best_lap_number] = lap.lap_number
                        pilot_result[:best_lap_time] = lap_pilot.lap_time
                    end

                    pilot_result[:average_speed] = (pilot_result[:average_speed] + lap_pilot.average_speed)/2
                    
                end

                if pilot_result[:atual_lap] == 4 
                    
                    pilot_position = {
                        pilot: pilot,
                        position: pilot_positions.length + 1,
                    }

                    pilot_positions.push(pilot_position)
                end


            end


            pilot_results.each do |pilot_result|

                pilot_position = pilot_positions.detect {
                    |pilot_position|
                    pilot_position[:pilot].pilot_number == pilot_result[:pilot_number]
                }

                if pilot_position
                    pilot_result[:position] = pilot_position[:position]
                end
            end

        end

        pilot_results
                .select{|item| item[:atual_lap] < 4}
                .sort {|a,b|
                comp = (a[:atual_lap_time] <=> b[:atual_lap_time])
                comp.zero? ? (b[:atual_lap] <=> a[:atual_lap]) : comp
                }.each do |item|
                    
                    pilot_position = {
                        pilot: nil,
                        position: pilot_positions.length + 1,
                    }

                    pilot_positions.push(pilot_position)

                    item[:position] = pilot_position[:position]

            end

            pilot_results.each do |item|
                item[:diferente_to_first] = Util.dec_time(pilot_results[0][:total_time], item[:total_time]) if item != pilot_results[0]
            end

            pilot_results.sort! {|a,b| a[:position] <=> b[:position]}

        return {
            best_lap: best_lap,
            best_lap_time: best_lap_time,
            best_lap_pilot: best_lap_pilot,
            pilot_results: pilot_results,
            pilots: pilots,
            name: race.name
        }

    end
end
