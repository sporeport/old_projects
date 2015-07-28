# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many(
    :goals,
    class_name: "Goal",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )

  attr_reader :password

  after_initialize :ensure_session_token

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_token
    self.session_token = User.generate_token
    self.save
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user && user.valid_password?(password)
    user
  end

  def incomplete_goals
    # fail
    goals.select {|goal| goal.complete == false && goal.valid?}
  end

  def completed_goals

    goals.select {|goal| goal.complete && goal.valid? }
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_token
  end

end
