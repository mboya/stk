class Payment < ApplicationRecord
  # validates :phone_number, uniqueness: true
  after_create :push_stk

  def push_stk
    begin
      response = MpesaStk::PushPayment.call(amount, phone_number)
      p response

      self.MerchantRequestID = response['MerchantRequestID']
      self.CheckoutRequestID = response['CheckoutRequestID']
      self.response = response
      self.save
    rescue => ex
      p ex.message

      self.response = ex.message
      self.save
    end
  end
end
