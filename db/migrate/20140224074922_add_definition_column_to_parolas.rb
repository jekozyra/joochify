class AddDefinitionColumnToParolas < ActiveRecord::Migration
  def change
    add_column :parolas, :definition, :text
  end
end
