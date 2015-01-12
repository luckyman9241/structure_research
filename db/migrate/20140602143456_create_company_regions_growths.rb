class CreateCompanyRegionsGrowths < ActiveRecord::Migration
  def change
    create_table :company_regions_growths do |t|
      t.integer :region_id
      t.integer :company_id
      t.float :value
      t.string :year
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
