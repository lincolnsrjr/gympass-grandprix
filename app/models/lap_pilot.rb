class LapPilot < ApplicationRecord
  belongs_to :pilot
  belongs_to :lap

  validates :lap_created_at, presence: true
  validates :lap_time, presence: true
  validates :average_speed, presence: true
  

  def self.add_lap_pilots(lap_pilots_hash, lap, pilots)

    lap_pilots_hash.each do |lap_pilot_hash|
          
        pilot = pilots.detect {
          |pilot|
          pilot[:pilot_number] == lap_pilot_hash[:pilot_number]
        }

        lap_pilot = LapPilot.new(
            lap_created_at: lap_pilot_hash[:lap_created_at],
            pilot_id: pilot[:id],
            lap_time: lap_pilot_hash[:lap_time],
            average_speed: lap_pilot_hash[:average_speed],
            lap_id: lap.id
        )

        if pilot[:last_lap] != (lap.lap_number - 1)
          raise NotAcceptableException.new(I18n.t(:lap_pilot_invalid))
        end

        pilot[:last_lap] = lap.lap_number

        if !lap_pilot.save
          raise NotAcceptableException.new(lap_pilot.errors.full_messages)
        end
    end

  end
end
