class Geo < ActiveRecord::Base
	validates :name, :uniqueness => true
	has_one :company_geo, dependent: :restrict_with_exception
end
