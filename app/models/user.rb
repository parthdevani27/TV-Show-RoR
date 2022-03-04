class User < ApplicationRecord
  # Include default devise modules. Others available are:
    has_many :favourites
    acts_as_favoritor
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
