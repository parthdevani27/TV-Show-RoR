class Show < ApplicationRecord
	mount_uploader:logo, ImageUploader
	belongs_to :channel, class_name: "Channel"
	has_many :favourites
	validate :date_validation
	 acts_as_favoritable

	  private def date_validation
	    if (Time.zone.now.to_date - self.startTime.to_date).to_i > 0
	      self.errors[:startTime] << "Please choose valid start time "
	    end
	    if (Time.zone.now.to_date - self.endTime.to_date).to_i > 0
	      self.errors[:endTime] << "Please choose valid end time"
	    end
	   	if (self.endTime - self.startTime).to_i <= 0
	      self.errors[:startTime] << "The start time shall not be higher then the end time."
	    end

	    @shows = Show.all
	    @shows.each do |item|
	    	if item.channel_id == self.channel_id && item.name != self.name
	    		if (item.startTime .. item.endTime).cover?(self.startTime)
	    			self.errors[:startTime] << "Start time is already scheduled for #{item.name}"
	    		end
	    		if (item.startTime .. item.endTime).cover?(self.endTime)
	    			self.errors[:endTime] << "End time is already scheduled for #{item.name}"
	    		end
	    		if (self.startTime .. self.endTime).cover?(item.startTime)
	    			self.errors[:startTime] << "#{item.name} is alredy scheduled from #{item.startTime} to #{item.endTime}"
	    		end
	    		if (self.startTime .. self.endTime).cover?(item.endTime)
	    			self.errors[:endTime] << "#{item.name} is alredy scheduled from #{item.endTime} to #{item.endTime}"
	    		end
	    	end
	    end
	  end
end


