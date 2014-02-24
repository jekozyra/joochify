class CreateParolas < ActiveRecord::Migration
  def change
    create_table :parolas do |t|
      t.string :input
      t.string :output

      t.timestamps
    end
  end
end
