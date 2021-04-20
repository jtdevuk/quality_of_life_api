class CreateShortlistedPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :shortlisted_places do |t|

      t.timestamps
    end
  end
end
