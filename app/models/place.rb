class Place < ApplicationRecord
  has_many :shortlisted_places
  has_many :users, through: :shortlisted_places
end