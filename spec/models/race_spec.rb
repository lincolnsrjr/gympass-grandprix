require 'rails_helper'

RSpec.describe Race, type: :model do

  it "should add a race" do
    LapPilot.destroy_all
    Lap.destroy_all
    Pilot.destroy_all
    Race.destroy_all

    race_params = Parse.race_input_to_hash(File.open("valid_input.txt"))
    race = Race.add(race_params[:laps], race_params[:pilots])
    
    expect(race).not_to eq nil
  end

  it "should F.MASSA winner the race" do
    LapPilot.destroy_all
    Lap.destroy_all
    Pilot.destroy_all
    Race.destroy_all

    race_params = Parse.race_input_to_hash(File.open("valid_input.txt"))
    race = Race.add(race_params[:laps], race_params[:pilots])
    
    race_info = Race.info(race.id)

    expect(race_info[:pilot_results][0][:name]).to eq "F.MASSA"
  end

  it "dont should S.VETTEL winner the race" do
    LapPilot.destroy_all
    Lap.destroy_all
    Pilot.destroy_all
    Race.destroy_all

    race_params = Parse.race_input_to_hash(File.open("valid_input.txt"))
    race = Race.add(race_params[:laps], race_params[:pilots])
    
    race_info = Race.info(race.id)

    expect(race_info[:pilot_results][0][:name]).not_to eq "S.VETTEL"
  end

  it "should F.MASSA winner the bestlap time on the race" do
    LapPilot.destroy_all
    Lap.destroy_all
    Pilot.destroy_all
    Race.destroy_all

    race_params = Parse.race_input_to_hash(File.open("valid_input.txt"))
    race = Race.add(race_params[:laps], race_params[:pilots])
    
    race_info = Race.info(race.id)

    expect(race_info[:best_lap_pilot]).to include "F.MASSA"
  end

  it "should raise error because race file is empty" do
    LapPilot.destroy_all
    Lap.destroy_all
    Pilot.destroy_all
    Race.destroy_all

    race_params = Parse.race_input_to_hash(File.open("error_input_1.txt"))
    begin
      race = Race.add(race_params[:laps], race_params[:pilots])
    rescue

    end

    expect(race).to eq nil
  end

  it "should raise error because one pilot in the race run 5 laps" do
    LapPilot.destroy_all
    Lap.destroy_all
    Pilot.destroy_all
    Race.destroy_all

    race_params = Parse.race_input_to_hash(File.open("error_input_2.txt"))
    begin
      race = Race.add(race_params[:laps], race_params[:pilots])
    rescue
      
    end

    expect(race).to eq nil
  end



end
