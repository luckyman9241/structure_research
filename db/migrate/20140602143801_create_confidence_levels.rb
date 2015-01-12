class CreateConfidenceLevels < ActiveRecord::Migration
  def change
    create_table :confidence_levels do |t|
      t.string :name
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
