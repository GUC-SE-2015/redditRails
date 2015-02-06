class User < ActiveRecord::Base
  self.primary_key = "username"
  before_save { self.username = username.downcase }
  validates :username, presence: true, format: { without: /\s/ }
  has_secure_password

  def to_param
    username.parameterize
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end 
end
