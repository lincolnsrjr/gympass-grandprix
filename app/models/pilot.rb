class Pilot < ApplicationRecord

    has_many :lap_pilots, dependent: :restrict_with_error 

    validates :name, presence: true
    validates :pilot_number, presence: true
    

    def full_info; "#{pilot_number} - #{name}"; end

    def self.add_pilots(pilots_hash)

        old_pilots = Pilot.select("id,name, pilot_number").all
        pilots = []
        pilots_hash.each do |pilot_hash|
            pilot = old_pilots.detect {
                |old_pilot|
                old_pilot.pilot_number == pilot_hash[:pilot_number]
            }

            if !pilot
                pilot = Pilot.new(
                    pilot_number: pilot_hash[:pilot_number],
                    name: pilot_hash[:name]
                )

                if !pilot.save
                    raise NotAcceptableException.new(pilot.errors.full_messages)
                end
            end
            pilots.push(pilot)
            
        end
        return pilots

    end

end
