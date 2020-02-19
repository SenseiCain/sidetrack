class VotesController < ApplicationController
    def create
        @vote = Vote.find_or_initialize_by(user_id: vote_params[:user_id], post_id: vote_params[:post_id])
        # byebug
        
        if @vote.new_record?
            @vote.status = to_boolean(vote_params[:status])
            @vote.save
        elsif @vote.status != to_boolean(vote_params[:status])
            @vote.status = to_boolean(vote_params[:status])
            @vote.save
        end
        redirect_to root_path
    end

    private

    def vote_params
        params.require(:vote).permit(:status, :user_id, :post_id)
    end

    def to_boolean(str)
        str == 'true'
    end
end