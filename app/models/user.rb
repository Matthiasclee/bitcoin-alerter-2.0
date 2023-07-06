class User < ApplicationRecord
  require 'net/http'
  require 'active_support/core_ext/numeric/conversions'

  def prices
    prices = {}

    resp = JSON.parse(Net::HTTP.get(URI("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD")))

    if resp["Response"] != "Error"
      price = resp["USD"].to_f.to_i
      prices[c.to_sym] = price
    else
      prices[c.to_sym] = -1
    end

    return prices
  end

  def message_data
    dat = ""

    prices.each do |p|
      if p[1]>-1
        dat << "#{p[0]}: $#{p[1].to_s(:delimited)}\n"
      else
        dat << "#{p[0]}: Sorry, something went wrong fetching this price."
      end
    end

    return dat.chomp
  end

  def send_message
    message = PricesmailerMailer.generate_message(phone: phone, carrier: carrier, price: message_data)
    message.deliver
  end
end
