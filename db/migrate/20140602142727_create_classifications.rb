class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string :name
      t.string :description
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
