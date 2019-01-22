class AddCheckoutRequestIdToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :CheckoutRequestID, :string
    add_column :payments, :MerchantRequestID, :string
  end
end
