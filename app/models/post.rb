class Post < ApplicationRecord
    before_save :make_post_title_case
    
    belongs_to :user
    has_many :posts_categories
    has_many :categories, through: :posts_categories
    has_many :comments
    has_many :votes

    validates :title, presence: true
    validates :description, presence: true

    def self.custom_filter(query)
        if query
            if query[:categories]
                Post.joins(:categories).where(categories: {id: query[:categories]})
            end
        else
            Post.all
        end
    end

    private

    def make_post_title_case
        self.title = self.title.titlecase
    end
end
