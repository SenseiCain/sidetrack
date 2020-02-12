class Post < ApplicationRecord
    before_save :make_post_title_case
    
    belongs_to :user

    has_many :posts_categories
    has_many :categories, through: :posts_categories

    has_many :comments

    validates :title, presence: true
    validates :description, presence: true

    private

    def make_post_title_case
        self.title = self.title.titlecase
    end
end
