class Post < ApplicationRecord
    belongs_to :user

    has_many :posts_categories
    has_many :categories, through: :posts_categories
    
    has_many :comments

    validates :title, presence: true
    validates :description, presence: true

end
