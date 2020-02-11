class Vote < ApplicationRecord
    belongs_to :user
    belongs_to :post

    validates :status, inclusion: { in: [ true, false ] }
end
