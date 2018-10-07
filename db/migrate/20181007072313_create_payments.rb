class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments, id: :uuid do |t|
      t.integer :amount
      t.string :phone_number

      t.timestamps
    end
  end
end
