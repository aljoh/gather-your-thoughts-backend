class Api::V1::ThoughtsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def create
    thought = Thought.new(thought_params.merge(user: current_api_v1_user))
    thought.label_list.add(params[:label_list])
    if thought.save
      render json: { status: 'success' }
    else
      render json: { error: thought.errors.full_messages },
             status: 422
    end
  end

  private

  def thought_params
    params.require(:thought).permit!
  end
end
