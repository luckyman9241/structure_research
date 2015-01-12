class CreateCompanyClassifications < ActiveRecord::Migration
  def change
    create_table :company_classifications do |t|
      t.integer :company_id
      t.integer :classification_id
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
