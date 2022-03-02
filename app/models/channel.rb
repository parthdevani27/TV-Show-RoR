class Channel < ApplicationRecord
	mount_uploader:logo, ImageUploader
	has_many :shows , dependent: :destroy
end
