class Place < ApplicationRecord
  require 'open-uri'
  def self.api_search(location)
    url = "https://api.teleport.org/api/cities/?search=#{location}"
    read_url = URI.open(url).read
    results = JSON.parse(read_url)
    results["_embedded"]["city:search-results"]
  end
end
