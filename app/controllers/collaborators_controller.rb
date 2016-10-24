class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    @user = User.find(params[:user_id])
    @wiki = @user.wikis.find(params[:id])
    @collaborator = Collaborator.new(wiki_id: params[:id], user_id: params[:user_id])
    #@users.where.not[user_id: current_user.id]

    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not added. Please try again."
      render :show
    end
   end

  def destroy

    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed from this wiki."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not removed. Please try again."
      render :show
    end
  end
end
