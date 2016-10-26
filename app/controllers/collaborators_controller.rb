class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    @user = User.find(params[:user_id])
    @wiki = @user.wikis.find(params[:id])
    @collaborator = Collaborator.new(wiki_id: params[:id], user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to [@wiki]
    else
      flash[:error] = "Collaborator was not added. Please try again."
      redirect_to [@wiki]
    end
   end

  def destroy

    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed from this wiki."
      redirect_to [@wiki]
    else
      flash[:error] = "Collaborator was not removed. Please try again."
      redirect_to [@wiki]
    end
  end
end
