class CompanyGeo < ActiveRecord::Base
	belongs_to :company
	belongs_to :geo
end
