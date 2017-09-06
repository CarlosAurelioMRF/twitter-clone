class RelationshipController < ApplicationController
  def following
    @users =  current_user.following
    @title = 'Seguindo'
    render 'show_follow'
  end

  def followers
    @users =  current_user.followers
    @title = 'Seguidores'
    render 'show_follow'
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)

    respond_to do | format |
      format.html { redirect_to posts_path, notice: 'Começou a seguir ' + @user.email }
    end
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)

    respond_to do | format |
      format.html { redirect_to posts_path, notice: 'Deixou de seguir ' + @user.email }
    end
  end

end
