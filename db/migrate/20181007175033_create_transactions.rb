class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :callback
      
      t.timestamps
    end
  end
end
