class Post < ApplicationRecord
    before_save :make_post_title_case
    
    belongs_to :user
    has_many :posts_categories
    has_many :categories, through: :posts_categories
    has_many :comments
    has_many :votes

    validates :title, presence: true
    validates :description, presence: true

    def self.select_by_category_and_date(query)
        if query
            @category = Category.find_by(id: query[:categories])

            if @category && query[:date].present?
                if query[:date] = 1
                    Post.joins(:categories).where(categories: {id: query[:categories]}, posts: {created_at: 1.week.ago..Time.new})
                elsif query[:date] = 2
                    Post.joins(:categories).where(categories: {id: query[:categories]}, posts: {created_at: 1.month.ago..Time.new})
                else
                    Post.joins(:categories).where(categories: {id: query[:categories]}, posts: {created_at: 1.year.ago..Time.new})
                end
            elsif @category
                Post.joins(:categories).where(categories: {id: query[:categories]})
            else
                Post.all
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
