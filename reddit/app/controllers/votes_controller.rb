class VotesController < ApplicationController
  before_action :log_in_required

  def up
    @sub = Subreddit.find_by_name(params[:subreddit_name])
    @post = @sub.posts.find_by_title(params[:title])
    current_user.upvote(@post)
    redirect_to [@sub, @post]
  end

  def down
    @sub = Subreddit.find_by_name(params[:subreddit_name])
    @post = @sub.posts.find_by_title(params[:title])
    current_user.downvote(@post)
    redirect_to [@sub, @post]
  end
end
