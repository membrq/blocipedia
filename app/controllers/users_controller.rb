class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis.all
  end
end
