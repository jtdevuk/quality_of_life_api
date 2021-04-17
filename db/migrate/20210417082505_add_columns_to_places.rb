class AddColumnsToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :name, :string
    add_column :places, :summary, :string
    add_column :places, :housing, :float
    add_column :places, :cost_of_living, :float
    add_column :places, :safety, :float
  end
end
