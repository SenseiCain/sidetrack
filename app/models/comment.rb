class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    validates :description, presence: true
    validates :post, presence: true
    validates :user, presence: true
end
