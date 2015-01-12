class CreateNdas < ActiveRecord::Migration
  def change
    create_table :ndas do |t|
      t.string :name
      t.integer :status
      t.timestamp :createdOn

      t.timestamps
    end
  end
end
