class State < ActiveRecord::Base

	validates :name, :uniqueness => true

	has_one :company, dependent: :restrict_with_exception
end
