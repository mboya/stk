class PushController < ApplicationController
  def index
    @payments = Payment.all.order(created_at: :desc)
  end

  def payment
    if params.present?
      phone = PhonyRails.normalize_number(params[:user][:phone_number], country_code: 'KE').gsub(/\W/, '')
      payment = Payment.new({ amount: params[:user][:amount], phone_number: phone })

      if payment.save
        redirect_to root_path, :flash => { :success => "Payment Created, Check Mobile device" }
      else
        redirect_to root_path, :flash => { :error => "Payment failed" }
      end
    end
  rescue Exception => e
    p e.message
  end

  def callback
    merchantrequestID = params[:Body][:stkCallback][:MerchantRequestID]
    checkoutrequestID = params[:Body][:stkCallback][:CheckoutRequestID]

    amount,mpesareceiptnumber,transactiondate,phonenumber=nil
    if params[:Body][:stkCallback][:CallbackMetadata].present?
      params[:Body][:stkCallback][:CallbackMetadata][:Item].each do |item|
        case item[:Name].downcase
        when 'amount'
          amount = item[:Value]
        when 'mpesareceiptnumber'
          mpesareceiptnumber = item[:Value]
        when 'transactiondate'
          transactiondate = item[:Value]
        when 'phonenumber'
          phonenumber = item[:Value]
        end
      end

      pay = Payment.find_by(amount: amount, phone_number: phonenumber, CheckoutRequestID: checkoutrequestID, MerchantRequestID: merchantrequestID)
      pay.state = true
      pay.code = mpesareceiptnumber
      pay.save

      render json: 'received'
    else
      pay = Payment.find_by(CheckoutRequestID: checkoutrequestID, MerchantRequestID: merchantrequestID)
      pay.code = params["Body"]["stkCallback"]["ResultDesc"]
      pay.save
    end
  Transaction.create({ callback: params })
  end

  def till_validation
    render json: 'ok'
  end

  def till_confirmation
    render json: 'ok'
  end

end
