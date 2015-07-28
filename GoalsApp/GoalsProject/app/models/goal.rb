# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  content     :text             not null
#  user_id     :integer          not null
#  complete    :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#  privateness :boolean          default(FALSE), not null
#

class Goal < ActiveRecord::Base
  validates :content, :user_id, presence: true
  validates :complete, :privateness, inclusion: { in: [true, false]}

  after_initialize :ensure_complete_and_privateness

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  private

  def ensure_complete_and_privateness
    self.complete ||= false
    self.privateness ||= false
  end
end
