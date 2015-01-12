class CreateCompanyRevenues < ActiveRecord::Migration
  def change
    create_table :company_revenues do |t|
    	t.integer :company_id
    	t.integer :revenue_id
    	t.float :year
    	t.integer :value
    	t.integer :status

      t.timestamps
    end
  end
end
