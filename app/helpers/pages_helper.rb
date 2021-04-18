module PagesHelper
  require 'open-uri'
  def api_search(place)
    places = []
    url = "https://api.teleport.org/api/cities/?search=#{place}&embed=city%3Asearch-results%2Fcity%3Aitem%2Fcity%3Aurban_area%2Fua%3Ascores
    "
    read_url = URI.open(url).read
    results = JSON.parse(read_url)    
    unless results["_embedded"]["city:search-results"].empty?      
      # return an array of place objects for the view to iterate through
      results["_embedded"]["city:search-results"].first(3).each do |result|
        city_item = result["_embedded"]["city:item"]
        # The API response only includes relevant quality of life info when city_item["_embedded"] is present, other results are ignored
        places << Place.create(build_place_from(city_item)) if city_item["_embedded"]        
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
    { name: name, summary: summary, housing: housing, cost_of_living: cost_of_living, safety: safety }
  end
end
