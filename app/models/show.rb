class Show < ApplicationRecord
	mount_uploader:logo, ImageUploader
	belongs_to :channel, class_name: "Channel"
end
