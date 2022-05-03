class AddIsbadToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_bad, :boolean, default: false
  end
end
