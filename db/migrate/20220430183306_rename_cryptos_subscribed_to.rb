class RenameCryptosSubscribedTo < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :cryptos_subscribed_to, :subscribed_to
  end
end
