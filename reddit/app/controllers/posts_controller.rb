class PostsController < ApplicationController
  before_action :log_in_required, only: [:create]
  def show
    @sub = Subreddit.find_by!(name: params[:subreddit_name])
    @post = @sub.posts.find_by!(title: params[:title])
    @comment = Comment.new
    current_user.view_post(@post) unless current_user.nil?
  end

  def create
    @sub = Subreddit.find_by!(name: params[:subreddit_name])
    @post = @sub.posts.new(post_params)
    @post.user = current_user
    if @post.save
      current_user.upvote(@post)
      redirect_to [@sub, @post]
    else
      redirect_to @sub
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
