class Lap < ApplicationRecord
  
  has_many :lap_pilots, dependent: :restrict_with_error 

  belongs_to :race

  validate :verify_lap_number
  validates :lap_number, presence: true

  def verify_lap_number
    if self.lap_number < 1 || self.lap_number > 4
      raise NotAcceptableException.new(I18n.t(:lap_number_invalid))
    end
  end

  def self.add_laps(laps_hash, race, pilots)

    laps_hash.each do |lap_hash|

      lap = Lap.new(
          lap_number: lap_hash[:lap_number],
          race_id: race.id  
      )

      if !lap.save
        raise NotAcceptableException.new(lap.errors.full_messages)
      end
      
      LapPilot.add_lap_pilots(lap_hash[:lap_pilots], lap, pilots)
      
    end

  end

end
