class Vote < ApplicationRecord
    belongs_to :user
    belongs_to :post

    validates :status, inclusion: { in: [ true, false ] }

    def self.create_upvote(user, post)
        create(status: true, user: user, post: post)
    end

    def self.create_downvote(user, post)
        create(status: false, user: user, post: post)
    end
end
