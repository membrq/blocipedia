class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: params[:wiki_id], user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to [@wiki.user, @wiki]
    else
      flash[:error] = "Collaborator was not added. Please try again."
      render :edit
    end
   end

  def destroy

    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed from this wiki."
      redirect_to [@wiki.user, @wiki]
    else
      flash[:error] = "Collaborator was not removed. Please try again."
      render :edit
    end
  end
end
