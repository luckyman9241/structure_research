class Investor < ActiveRecord::Base
validates :name, :uniqueness => true
belongs_to :company
end
