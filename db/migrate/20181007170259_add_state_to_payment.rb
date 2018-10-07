class AddStateToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :state, :boolean, default: false
    add_column :payments, :code, :string
  end
end
