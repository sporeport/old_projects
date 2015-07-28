class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_token

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)

    if @user
      if @user.is_password?(password)
        @user
      else
        nil
      end
    else
      nil
    end
  end

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_token
    self.session_token = User.generate_token
  end

  private

  def ensure_token
    self.session_token ||= User.generate_token
  end

end
