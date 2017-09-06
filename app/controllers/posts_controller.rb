class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]

  def index
    @tipo_listagem = params[:list]

    if @tipo_listagem != 'following'
      @posts = Post.includes(:user).order(created_at: :desc)
    else
      @posts = Post.where(:user_id => current_user.id).order(created_at: :desc)

      current_user.following.each do | following |
        @posts = @posts + Post.where(:user_id => following.id).order(created_at: :desc)
      end
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = User.find(current_user.id)

    respond_to do |format|
      if @post.save
        format.html { redirect_to action: "index", notice: 'Post was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Postagem deletada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:message, :user_id)
    end
end
