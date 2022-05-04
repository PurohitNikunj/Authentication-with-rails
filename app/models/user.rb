class User < ApplicationRecord
    has_secure_password
    validates :password, confirmation: true
    validates_presence_of :username, :password, :password_confirmation
    has_many :sessions, dependent: :destroy

end
