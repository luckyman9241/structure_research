class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
