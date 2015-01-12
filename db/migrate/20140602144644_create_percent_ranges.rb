class CreatePercentRanges < ActiveRecord::Migration
  def change
    create_table :percent_ranges do |t|
      t.integer :value
      t.string :range
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
