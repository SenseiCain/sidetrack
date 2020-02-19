class VotesController < ApplicationController
    def create
    end

    private

    def vote_params
        params.require(:vote).permit(:status, :user_id, :post_id)
    end
end