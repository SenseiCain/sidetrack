class User < ApplicationRecord
    has_secure_password

    has_many :posts
    has_many :comments
    has_many :votes

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    def url_encoded_name
        name.gsub(' ', '-').downcase
    end

    def display_formatted_name
        name.titlecase
    end
end
