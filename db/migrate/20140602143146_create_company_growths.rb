class CreateCompanyGrowths < ActiveRecord::Migration
  def change
    create_table :company_growths do |t|
      t.integer :company_id
      t.integer :growth_id
      t.float :value
      t.string :year
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
