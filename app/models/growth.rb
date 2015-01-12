class Growth < ActiveRecord::Base
	validates :name, :uniqueness => true
	has_one :companyGrowth, dependent: :restrict_with_exception
end
