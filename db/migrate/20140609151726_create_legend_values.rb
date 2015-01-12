class CreateLegendValues < ActiveRecord::Migration
  def change
    create_table :legend_values do |t|
     t.integer :legend_id
     t.string :range
     t.string :value
     t.integer :status
     t.timestamps
    end
  end
end
