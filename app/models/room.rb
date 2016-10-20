class Room < ActiveRecord::Base
	resourcify
	attr_accessor :facilities_fields
	
	has_many :bookings, dependent: :destroy
	has_and_belongs_to_many :facilities
	accepts_nested_attributes_for :facilities
	
	after_save :create_facilities
  
  validates :room_no, :title, presence: true

	def create_facilities
		self.facilities.delete_all
		facilitites = Facility.where(id: self.facilities_fields[:id])
		self.facilities << facilitites
	end
end
