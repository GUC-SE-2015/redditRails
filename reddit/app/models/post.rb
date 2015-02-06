class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :subreddit_id}
  validates :body, presence: true
  before_save { self.title = title.downcase }
  belongs_to :subreddit
  belongs_to :user
  has_many :views
  has_many :comments
  has_many :votes


  def to_param
    title.parameterize
  end

end
