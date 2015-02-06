class SubredditsController < ApplicationController

  def index
    @subs = Subreddit.all
  end

  def create
    @sub = Subreddit.new(sub_params)
    if @sub.save
      redirect_to @sub
    else
      render 'new'
    end
  end

  def new
    @sub = Subreddit.new
  end

  def show
    @sub = Subreddit.find_by!(name: params[:name])
    @post = Post.new
  end

  private
    def sub_params
      params.require(:subreddit).permit(:name)
    end
end
