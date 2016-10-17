class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    @user = User.find(params[:id])
    @wiki = @user.wikis.find(params[:id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: @user.id])


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
