class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy,
                                            :following, :followers]
  before_action :correct_user,   only: [ :show, :edit, :update]

  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @outlet_image = @user.following.pluck(:imageurl)
    @articles = @user.fetch_articles(published_before: params[:feed_data])
    respond_to :html, :js
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @outlets = @user.fetch_outlets(outlet: params[:feed_data])
    respond_to :html, :js
    render :show_follow
  end

  private
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user == @user
    end
end

#User.delete_all
#ActiveRecord::Base.connection.reset_pk_sequence!('users')
