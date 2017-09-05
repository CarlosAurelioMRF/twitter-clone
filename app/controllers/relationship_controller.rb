class RelationshipController < ApplicationController
  def following
    @users =  current_user.following
    render 'show_follow'
  end

  def followers
    @users =  current_user.followers
    render 'show_follow'
  end

end
