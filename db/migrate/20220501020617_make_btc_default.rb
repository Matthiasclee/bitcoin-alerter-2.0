class MakeBtcDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :subscribed_to, ["BTC"]
  end
end
