class AddResponseToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :response, :string
  end
end
