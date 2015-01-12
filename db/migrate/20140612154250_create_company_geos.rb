class CreateCompanyGeos < ActiveRecord::Migration
  def change
    create_table :company_geos do |t|
    	t.integer :company_id
    	t.integer :geo_id
    	t.float :year
    	t.string :value
    	t.integer :status
      t.timestamps
    end
  end
end
