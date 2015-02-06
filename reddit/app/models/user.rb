class User < ActiveRecord::Base
  before_save { self.username = username.downcase }
  validates :username, presence: true, format: { without: /\s/ }
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :views
  has_many :votes


  def to_param
    username.parameterize
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end 

  def User.gen_token
    SecureRandom.urlsafe_base64
  end

  def remember
    remember_token = User.gen_token
    update_attribute remember_digest: User.digest(remember_token)
  end

  def token_matches?(remember_token)
    return false if remember_token.nil?
    BCrypt::Password.new(remember_diget) == remember_token
  end

  def forget
    update_attribute remember_digest: nil
  end

  def view_post(post)
    post.views.create(user: self) if views.find_by_post_id(post.id).nil?
  end

  def upvoted?(post)
    votes.where(post_id: post.id, weight: 1).any?
  end
  
  def downvoted?(post)
    !upvoted?
  end

  def upvote(post)
    remove_vote(post)
    votes.create(post: post, weight: 1)
  end

  def downvote(post)
    remove_vote(post)
    votes.create(post: post, weight: -1)
  end

  def karma
    posts.map { |post| post.votes.sum(:weight) }.sum
  end

  def remove_vote(post)
    votes.where(post: post).delete_all
  end

end
