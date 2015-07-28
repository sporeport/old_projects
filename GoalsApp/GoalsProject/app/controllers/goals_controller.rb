class GoalsController < ApplicationController

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      @user = current_user
      render "users/show"
    end
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      @user = current_user
      render "users/show"
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:content, :privateness, :complete)
  end
end
