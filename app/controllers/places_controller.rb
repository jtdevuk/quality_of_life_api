class PlacesController < ApplicationController
  before_action :place_params, only: :create

  def create
    @place = Place.new(place_params)
    @place.save
  end

  def show
    @place = Place.find(params[:id])
  end

  private

  def place_params
    params.require(:place).permit(:name, :summary, :housing, :cost_of_living, :safety)
  end
end