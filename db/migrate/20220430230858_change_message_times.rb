class ChangeMessageTimes < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :start_messages_at, "6"
    change_column_default :users, :end_messages_at, "20"
  end
end
