class CreateBaseValues < ActiveRecord::Migration
  def change
    create_table :base_values do |t|
      t.integer :company_id
      t.integer :revenue_type
      t.float :base_growth_value
      t.float :base_value
      t.float :growth_value
      t.float :value
      t.integer :year
      t.integer :is_base
      
      t.timestamps
    end
  end
end
