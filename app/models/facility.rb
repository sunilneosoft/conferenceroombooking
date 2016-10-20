class Facility < ActiveRecord::Base
	has_and_belongs_to_many :rooms
	accepts_nested_attributes_for :rooms
    
  def self.search(params)
    unless params[:search_keyword].blank?
      #Facility.where("title ilike '%#{params[:search_keyword].strip}%'")
      Room.joins(:facilities).where("facilities.title ilike '%#{params[:search_keyword].strip}%'")
    end
  end
end
