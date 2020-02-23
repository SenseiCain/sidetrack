class VotesController < ApplicationController
    def create
        if current_user
            @vote = Vote.find_or_initialize_by(user_id: vote_params[:user_id], post_id: vote_params[:post_id])
            
            if @vote.new_record?
                @vote.create(status: params_status)
            elsif @vote.status != params_status
                @vote.flip_vote
            end
        end
        
        redirect_to root_path
    end

    private

    def vote_params
        params.require(:vote).permit(:status, :user_id, :post_id)
    end

    def params_status
        vote_params[:status] == 'true'
    end
end