class AddReferencesToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_reference :places, :user, foreign_key: true
  end
end
