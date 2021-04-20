class AddColumnsToShortlistedPlaces < ActiveRecord::Migration[6.0]
  def change
    add_reference :shortlisted_places, :user, null: false, foreign_key: true
    add_reference :shortlisted_places, :place, null: false, foreign_key: true
  end
end
