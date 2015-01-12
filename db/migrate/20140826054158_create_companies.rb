class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :analyst_id
      t.integer :status_id
      t.integer :confidence_level_id
      t.integer :nda_id
      t.integer :country_id
      t.integer :region_id
      t.integer :city_id
      t.integer :state_id
      t.string :website
      t.string :parent_company
      t.integer :company_type_id
      t.string :CEO
      t.string :PSL
      t.integer :no_of_DCS
      t.string :dclocation
      t.string :dcpartner
      t.float  :revenue
      t.string :revenue_year
      t.timestamps
    end
  end
end
