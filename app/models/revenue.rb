class Revenue < ActiveRecord::Base
	validates :name, :uniqueness => true
	has_one :CompanyRevenue, dependent: :restrict_with_exception
end
