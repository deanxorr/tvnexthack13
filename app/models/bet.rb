# == Schema Information
#
# Table name: bets
#
#  id         :integer          not null, primary key
#  body       :text
#  time       :integer
#  tms_id     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_name  :string(255)
#  user_email :string(255)
#  wager      :text             default("10 points")
#

class Bet < ActiveRecord::Base
  attr_accessible :body, :time, :tms_id

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.user_email.downcase! }

  validates :body, presence: true, length: { minimum: 4}
  validates :time, presence: true
  validates :tms_id, presence: true
  validates :user_name, presence: true
  validates :user_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :wager, presence: true
end
