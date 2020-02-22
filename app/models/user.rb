class User < ApplicationRecord
    has_secure_password

    has_many :posts
    has_many :comments
    has_many :votes

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, confirmation: true
    validates_confirmation_of :email
    validates :password, presence: true, confirmation: true
    validates_confirmation_of :password

    def url_encoded_name
        name.gsub(' ', '-').downcase
    end

    def display_formatted_name
        name.titlecase
    end
end
