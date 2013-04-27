class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.text :body
      t.integer :time
      t.string :tms_id

      t.timestamps
    end
  end
end
