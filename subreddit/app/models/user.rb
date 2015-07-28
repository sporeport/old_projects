# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  user_name       :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates(
    :email,
    :user_name,
    :password_digest,
    :session_token,
    presence: true
  )
  validates :email, :session_token, uniqueness: true

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)

    return nil unless user

    if BCrypt::Password.new(user.password_digest).is_password?(password)
      user
    else
      nil
    end
  end

  attr_reader :password
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :moderated_subs,
    class_name: 'PostSub',
    foreign_key: :moderator_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :posts,
    class_name: 'Post',
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :comments,
    class_name: 'Comment',
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy
  )

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_token!
    self.session_token = SecureRandom::urlsafe_base64
    save!
  end

  private

  def ensure_session_token
    return if self.session_token

    self.session_token = SecureRandom::urlsafe_base64
  end
end
