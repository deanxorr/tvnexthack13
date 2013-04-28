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

require 'test_helper'

class BetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
