class ChangeGoalPrivateness < ActiveRecord::Migration
  def change
    remove_column :goals, :private
    add_column :goals, :privateness, :boolean
    change_column :goals, :privateness, :boolean, default: false, null: false
  end
end
