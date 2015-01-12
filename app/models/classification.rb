class Classification < ActiveRecord::Base
	validates :name, :uniqueness => true
	has_many :companyClassifications, dependent: :restrict_with_exception
	has_many :companies, :through => :companyClassifications
end
