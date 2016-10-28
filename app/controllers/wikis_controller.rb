class WikisController < ApplicationController

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @user = User.find(params[:user_id])
    @wiki = @user.wikis.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Entry saved successfully."
      redirect_to [@wiki.user, @wiki]
    else
      flash[:alert] = "Entry failed to save."
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    #@wiki = current_user.wikis.find(params[:id])

    unless @wiki.private? || current_user == @wiki.user
      flash[:alert] = "You must be a premium user or an admin to view private wikis!"
      redirect_to wikis_path
    end
  end

  def edit
    @users = User.all
    @wiki = Wiki.find(params[:id])

    authorize(@wiki)
  end

  def update
    @user = User.find(params[:user_id])
    @wiki = @user.wikis.find(params[:id])
    authorize(@wiki)

    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to [@wiki.user, @wiki]
    else
      flash[:alert] = "There was an error updating your wiki."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @wiki = @user.wikis.find(params[:id])
    authorize(@wiki)

    if @wiki.destroy
      flash[:notice] = "Entry was deleted."
      redirect_to [@user]
    else
      flash[:alert] = "Entry couldn't be deleted. Try again!"
      redirect_to [@user]
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
