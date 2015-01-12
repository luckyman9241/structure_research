class User < ActiveRecord::Base
	validates :username, :uniqueness => true
	belongs_to :user_type
end
