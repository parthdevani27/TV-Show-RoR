class Favourite < ApplicationRecord
	belongs_to :user, class_name: "User"
    belongs_to :show, class_name: "Show"
end
