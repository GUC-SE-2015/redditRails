class CommentsController < ApplicationController
  before_action :log_in_required, only [:create]
  def create
    sub = Subreddit.find_by_name(params[:subreddit_name])
    post = sub.posts.find_by_title(params[:post_title])
    comment = Comment.new(comment_params)
    comment.post = post
    comment.user = current_user
    comment.save
    redirect_to [sub, post]
  end
  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def log_in_required
      unless logged_in?
        flash[:danger] = "Login Required."
        redirect_to new_session_path
      end
    end

end
