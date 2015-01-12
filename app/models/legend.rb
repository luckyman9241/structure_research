class Legend < ActiveRecord::Base
	validates :name, :uniqueness => true
	has_many :legend_value, dependent: :restrict_with_exception
end
