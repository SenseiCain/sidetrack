class Post < ApplicationRecord
    belongs_to :user

    has_many :posts_categories
    has_many :categories, through: :posts_categories

    has_many :comments

    # has_many :posts_tags
    # has_many :tags, through: :posts_tags

end
