class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [ :show, :edit, :update]

  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @outlet_image = @user.following.all.pluck(:imageurl)
    @outlets = @user.following.all.pluck(:outlet_name)

    if params[:feed_data]
      @articles = Article.includes(:outlet).where(outlet_name: @outlets).where('articles.published_at < ?', params[:feed_data].to_datetime).limit(5)
    else
      @articles = Article.includes(:outlet).where(outlet_name: @outlets).limit(5)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])

    if params[:feed_data]
      @outlets = @user.following.where("outlet_name > ?", params[:feed_data])
    else
      @outlets = @user.following.limit(5)
    end
    respond_to do |format|
      format.html
      format.js
    end

    render 'show_follow'
  end

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless user_signed_in?
        flash[:danger] = "Please log in."
        redirect_to new_user_registration_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user == @user
    end
end

#User.delete_all
#ActiveRecord::Base.connection.reset_pk_sequence!('users')
