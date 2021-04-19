class PlacesController < ApplicationController
  before_action :place_params, only: :create
  before_action :set_place, only: [:show, :add_to_shortlist, :remove_from_shortlist]

  def create
    @place = Place.new(place_params)
    @place.save
  end

  def show    
  end

  def add_to_shortlist
    current_user.places << @place
    redirect_to shortlist_path
  end

  def remove_from_shortlist
    current_user.places.delete(@place)
    redirect_to shortlist_path
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :summary, :housing, :cost_of_living, :safety)
  end
end