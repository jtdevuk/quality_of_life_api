class Place < ApplicationRecord
  require 'open-uri'
  def self.api_search(place)
    url = "https://api.teleport.org/api/cities/?search=#{place}&embed=city%3Asearch-results%2Fcity%3Aitem%2Fcity%3Aurban_area%2Fua%3Ascores
    "
    read_url = URI.open(url).read
    results = JSON.parse(read_url)    
    unless results["_embedded"]["city:search-results"].empty?      
      # return an array of place objects for the view to iterate through
      results["_embedded"]["city:search-results"].each do |result|
        city_item = result["_embedded"]["city:item"]
        if city_item["_embedded"]
          name = city_item["_embedded"]["city:urban_area"]["full_name"]
          categories = city_item["_embedded"]["city:urban_area"]["_embedded"]["ua:scores"]["categories"]
          housing = categories[0]["score_out_of_10"]
          cost_of_living = categories[1]["score_out_of_10"]
          safety = categories[7]["score_out_of_10"]
          description = city_item["_embedded"]["city:urban_area"]["_embedded"]["ua:scores"]["summary"]
        else
          # name if there isn't any ["city:item"]["_embedded"]
          # is ["_embedded"]["city:item"]["full_name"]
          name = city_item["full_name"]          
        end
      end
    end
  end
end
