class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :shortlisted_places
  has_many :places, through: :shortlisted_places

end
