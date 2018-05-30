class RacesController < ApplicationController

  def index 
    @data = Race.index
    p "notice" , notice 
  end

  def create
    respond_to do |format|
      begin 
        ActiveRecord::Base.transaction do
          race_params = Parse.race_input_to_hash(params[:file])
          race = Race.add(race_params[:laps], race_params[:pilots])
          format.html { redirect_to races_info_path(race) }
        end
      rescue => e
        p e
        p e.backtrace
        p e.message
        format.html { redirect_to races_index_path, notice: e.message }
      end
    end
  end

  def info
    @data = Race.info(params[:id])
  end

end