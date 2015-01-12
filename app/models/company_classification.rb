class CompanyClassification < ActiveRecord::Base
	belongs_to :company
	belongs_to :classification
	
end
