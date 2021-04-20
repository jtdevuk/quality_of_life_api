module PagesHelper
  # retrieve API response for user provided search term and parse into hash object
  def api_search(place)
    places = []
    url = "https://api.teleport.org/api/cities/?search=#{place}&embed=city%3Asearch-results%2Fcity%3Aitem%2Fcity%3Aurban_area%2Fua%3Ascores"
    read_url = URI.open(url).read
    results = JSON.parse(read_url)
    
    # check if results hash contains an array of city:search-results
    unless results["_embedded"]["city:search-results"].empty?
      results["_embedded"]["city:search-results"].first(3).each do |result|
        city_item = result["_embedded"]["city:item"]
        # The API response only includes relevant quality of life data when city_item["_embedded"] is present      
        if city_item["_embedded"]
          # 'build' a new place from provided data, or return a pre-existing object which matches by name. Method in places_helper.rb
          place = build_place_from(city_item)
          # check that there isn't already an identical Place in the places array, as the API sometimes gives duplicate results
          unless places.any? {|p| p.name == place.name }
            places << place
          end
        end
      end
    end
    # return an array of place objects for the view to iterate through
    places
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
