class User < ApplicationRecord
    has_secure_password

    has_many :posts
    has_many :comments
    has_many :votes

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
