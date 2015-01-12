class CreateRevenues < ActiveRecord::Migration
  def change
    create_table :revenues do |t|
    	t.string :name
    	t.string :description
    	t.integer :status
      t.timestamps
    end
  end
end
