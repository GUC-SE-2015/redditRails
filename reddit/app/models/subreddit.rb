class Subreddit < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  before_save { self.name = name.downcase }
  has_many :posts

  def to_param
    name.parameterize
  end
end
