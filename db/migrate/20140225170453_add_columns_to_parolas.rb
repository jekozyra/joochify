class AddColumnsToParolas < ActiveRecord::Migration
  def change
    add_column :parolas, :part_of_speech, :string
    add_column :parolas, :etymology_language, :string
  end
end
