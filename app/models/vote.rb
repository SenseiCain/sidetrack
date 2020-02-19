class Vote < ApplicationRecord
    belongs_to :user
    belongs_to :post

    validates :status, inclusion: { in: [ true, false ] }, uniqueness: { scope: [:user_id, :post_id] }
    validates :user, presence: true
    validates :post, presence: true
end
