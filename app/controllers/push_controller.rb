class PushController < ApplicationController
  def index
    @payments = Payment.all
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
    amount,mpesareceiptnumber,transactiondate,phonenumber=nil
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

    binding.pry

    pay = Payment.find_by(amount: amount, phone_number: phonenumber)
    pay.state = true
    pay.code = mpesareceiptnumber
    pay.save

    Transaction.create({ callback: params })

    render json: 'received'
  end

end
