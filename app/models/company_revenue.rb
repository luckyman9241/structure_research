class CompanyRevenue < ActiveRecord::Base
	belongs_to :company
	belongs_to :revenue
end
