class CreateCompanyTypes < ActiveRecord::Migration
  def change
    create_table :company_types do |t|
      t.string :name
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
