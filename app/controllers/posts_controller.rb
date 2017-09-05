class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]

  def index
    @posts = Post.includes(:user).order("created_at DESC")

    @posts.each do | post |
      if post.user.email == 'carlos.ribeiiro@hotmail.com'
        puts 'TESTE ENTREGOU'
        @user = post.user
      end
     end

    current_user.follow(@user)
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
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
