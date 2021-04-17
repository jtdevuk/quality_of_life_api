class PlacesController < ApplicationController
  before_action: :place_params, only: [create]

  def create
    @place = Place.new(place_params)
    @place.save
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :housing, :cost_of_living, :safety)
  end

end