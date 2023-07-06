class CreateUsers1 < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :phone, null: false
      t.integer :carrier, null: false

      t.timestamps
    end
  end
end
