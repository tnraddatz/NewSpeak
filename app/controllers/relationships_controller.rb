class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @outlet = Outlet.find(params[:followed_id])
    current_user.follow(@outlet)
    respond_to do |format|
      format.html { redirect_to @outlet }
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

end
