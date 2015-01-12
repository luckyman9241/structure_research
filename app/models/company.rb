class Company < ActiveRecord::Base
	belongs_to :confidenceLevel
	belongs_to :nda
	belongs_to :country
	belongs_to :region
	belongs_to :state
	belongs_to :city
	belongs_to :analyst
	belongs_to :status
	belongs_to :company_type
	has_many :companyGrowths
	has_many :companyRevenues
	has_many :companyGeos
	has_many :geos, through: :companyGeos

	has_many :companyInvestors
	has_many :companyClassifications
	has_many :classifications, through: :companyClassifications

	validates :name, :uniqueness => true
end
