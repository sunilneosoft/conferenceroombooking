module ApplicationHelper

	def date_format(date)
		DateTime.parse(date.to_s).strftime("%d-%m-%Y %I:%M:%S %p")
	end
end
