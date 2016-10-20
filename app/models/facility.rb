class Facility < ActiveRecord::Base
	has_and_belongs_to_many :rooms
	accepts_nested_attributes_for :rooms
end
