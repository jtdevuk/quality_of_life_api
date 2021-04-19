module PagesHelper
  def api_search(place)
    places = []
    url = "https://api.teleport.org/api/cities/?search=#{place}&embed=city%3Asearch-results%2Fcity%3Aitem%2Fcity%3Aurban_area%2Fua%3Ascores"
    read_url = URI.open(url).read
    results = JSON.parse(read_url) 
   
    unless results["_embedded"]["city:search-results"].empty?      
      # return an array of place objects for the view to iterate through
      results["_embedded"]["city:search-results"].first(3).each do |result|
        city_item = result["_embedded"]["city:item"]
        # The API response only includes relevant quality of life info when city_item["_embedded"] is present, other results are ignored        
        if city_item["_embedded"]
          # set all values and instantiate Place object from provided data
          place = build_place_from(city_item)
          # check that there isn't already an identical Place in the places array
          unless places.any? {|place| place.name == place.name }
            places << place
          end
        end
      end
    end
    places
  end

  def build_place_from(city_item)
    urban_area = city_item["_embedded"]["city:urban_area"]
    name = urban_area["full_name"]
    categories = urban_area["_embedded"]["ua:scores"]["categories"]
    housing = categories[0]["score_out_of_10"]
    cost_of_living = categories[1]["score_out_of_10"]
    safety = categories[7]["score_out_of_10"]
    summary = urban_area["_embedded"]["ua:scores"]["summary"]
    Place.create({ name: name, summary: summary, housing: housing, cost_of_living: cost_of_living, safety: safety })
  end

  def set_sort_order(places)
    sort_order = params[:sort]

    if sort_order == "housing"
      places.sort_by(&:housing).reverse
    elsif sort_order == "safety"
      places.sort_by(&:safety).reverse
    elsif sort_order == "cost of living"
      places.sort_by(&:cost_of_living).reverse
    end
  end

  def set_bar_colour(data)
    # sets bar colours for "shared/graph partial"
    if data < 3.33
      "red"
    elsif data > 3.33 && data <= 6.66
      "orange"
    else
      "green"
    end
  end
  
end
