module PlacesHelper
  def build_place_from(city_item)
    urban_area = city_item["_embedded"]["city:urban_area"]
    name = urban_area["full_name"]
    categories = urban_area["_embedded"]["ua:scores"]["categories"]
    housing = categories[0]["score_out_of_10"]
    cost_of_living = categories[1]["score_out_of_10"]
    safety = categories[7]["score_out_of_10"]
    summary = urban_area["_embedded"]["ua:scores"]["summary"]
    # if the place already exists in the DB, return this existing place
    if Place.any? { |p| p.name == name }
      harry = Place.where(name: name).first      
    else
      # if the place doesn't exist, create a new one
      Place.create({ name: name, summary: summary, housing: housing, cost_of_living: cost_of_living, safety: safety })
    end
  end
end
