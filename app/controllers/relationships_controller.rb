class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @outlet = Outlet.find(params[:followed_id])
    current_user.follow(@outlet)
    respond_to do |format|
      format.html { redirect_to @outlet}
      format.js
    end
  end

  def destroy
    @outlet = Relationship.find(params[:id]).followed
    current_user.unfollow(@outlet)
    respond_to do |format|
      format.html { redirect_to @outlet }
      format.js
    end
  end

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless user_signed_in?
        flash[:danger] = "Please log in."
        redirect_to new_user_registration_url
      end
    end
end
