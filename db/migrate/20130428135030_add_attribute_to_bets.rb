class AddAttributeToBets < ActiveRecord::Migration
  def change
    add_column :bets, :user_name, :string
    add_column :bets, :user_email, :string
    add_column :bets, :wager, :text, default: "10 points"
  end
end
