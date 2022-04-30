class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :phone, null: false
      t.string :cryptos_subscribed_to, array: true, default: []
      t.string :stocks_subscribed_to, array: true, default: []
      t.string :start_messages_at, default: "6AM"
      t.string :end_messages_at, default: "8PM"
      t.boolean :send_hourly_messages, default: true

      t.timestamps
    end
  end
end
