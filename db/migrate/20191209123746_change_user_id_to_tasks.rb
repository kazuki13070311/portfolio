class ChangeUserIdToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :user_id, :integer, null: false
  end
end
