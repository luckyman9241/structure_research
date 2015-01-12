class CreateGrowths < ActiveRecord::Migration
  def change
    create_table :growths do |t|
      t.string :name
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
