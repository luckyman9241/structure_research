class ConfidenceLevel < ActiveRecord::Base
	has_one :company, dependent: :restrict_with_exception
end
