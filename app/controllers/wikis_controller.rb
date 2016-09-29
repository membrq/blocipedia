class WikisController < ApplicationController
  #after_action :verify_authorized

  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @user = User.find(params[:user_id])
    @wiki = @user.wikis.new(wiki_params)
    @wiki.user = current_user
    #@new_wiki = Item.new

    if @wiki.save
      flash[:notice] = "Entry saved successfully."
      redirect_to [@wiki.user, @wiki]
    else
      flash[:alert] = "Entry failed to save."
      render :new
    end

    #respond_to do |format|
      #format.html
      #format.js
    #end
  end

  def show
    @wiki = current_user.wikis.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    authorize @user
    @wiki = @user.wikis.find(params[:id])

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
    authorize @user
    @wiki = @user.wikis.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Entry was deleted."
      redirect_to [@user]
    else
      flash[:alert] = "Entry couldn't be deleted. Try again!"
      redirect_to [@user]
    end

    #respond_to do |format|
    #  format.html
    #  format.js
    #end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end

end
