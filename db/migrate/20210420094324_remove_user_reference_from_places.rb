class RemoveUserReferenceFromPlaces < ActiveRecord::Migration[6.0]
  def change
    remove_reference :places, :user, index: true, foreign_key: true
  end
end
