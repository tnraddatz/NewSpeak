class UsersController < ApplicationController
  # Have yourn names be more meaning ful here.
  # ie before_action authorize_user! or authenticate_user!
  #
  before_action :logged_in_user, only: [:edit, :update, :destroy,
                                        :following, :followers]

  before_action :correct_user, only: [:show, :edit, :update]

  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    # this seems like an anti-pattern. If you are hitting the DB 2x to pull the names and the image urls.
    # Actual. There a lre a LOT of DB hits here for some selective queries. This is going to bite you in the ass soon.
    # If this is user centric. I would make a method in the user model.
    #
    # class User < ApplicationRecord
    #
    # ...
    #
    #   def fetch_articles(published_before: nil)
    #     @records = Articles.where(outlet_name: following.pluck(:outlet_name)) #the #all is not needed.
    #     if published_at
    #       @records = @records.where('articles.published_at < ?', params[:feed_data].to_datetime)
    #     end
    #   @records
    # end
    #
    # this allows you to just call
    # @user.fetch_articles(published_at: params[:feed_data])
    # # also. is feed data the right word. maybe you should call it "date_range" ?
    #
    # This would clean all of this up by...

    @articles = @user.fetch_articles(published_before: params[:date_range])

    respond_to do |format|
      format.html
      format.js
    end
  end

  #see... we just cleaned up a LOT of code. And its easier to test the model here, and not the controller.

  def following
    # Why are you settng a static string here?
    @title = "Following"
    @user = User.find(params[:id])

    @outlets = if params[:feed_data]
                 @user.following.where("outlet_name > ?", params[:feed_data])
                 # what is the purpose to checking a name is ... greater then the feed data. I have no clue what you are
                 # trying to accomplish here.
               else
                 # another repetitious code deceleration.
                 @user.following.limit(5)
               end

    respond_to :html, :js
    # you keep declaring this pattern. looks like this is from a generator. Bad habit.
    # You should only declare mime types that you will be using.

    render 'show_follow' # <- should be a symbol.
  end

  private

  # Confirms a logged-in user.

  # Looks like you should have this in the application controller. Move this out. 
  # This will ensure that you dont need to keep adding it to every controller.  
  # Imagine that you had 100 controllers. And you wanted to make a change to the manner in which your process auth.
  # You'll be doing a lot of edits.

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
