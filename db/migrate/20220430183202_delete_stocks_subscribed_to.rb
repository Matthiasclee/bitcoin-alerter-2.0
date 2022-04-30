class DeleteStocksSubscribedTo < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :stocks_subscribed_to
  end
end
