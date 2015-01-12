class CreateCompanyInvestors < ActiveRecord::Migration
  def change
    create_table :company_investors do |t|
      t.integer :company_id
      t.string :investor
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
