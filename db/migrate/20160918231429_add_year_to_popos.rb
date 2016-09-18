class AddYearToPopos < ActiveRecord::Migration[5.0]
  def change
    add_column :popos, :year, :integer
    add_column :popos, :seating, :boolean
    add_column :popos, :seating_description, :text
    add_column :popos, :environment, :string
  end
end
