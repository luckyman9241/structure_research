class CreateLegends < ActiveRecord::Migration
  def change
    create_table :legends do |t|
      t.string :FX_rate
      t.string :currency
      t.string :name
      #t.integer :year_avg_id
      t.string :currency_prefix
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
