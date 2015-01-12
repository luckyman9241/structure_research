class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :fullname
    	t.string :username
    	t.string :password
    	t.integer :user_type_id
    	t.integer :status
    t.timestamps
    end
  end
end
