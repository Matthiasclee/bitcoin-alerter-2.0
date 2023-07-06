class User < ApplicationRecord
  require 'net/http'
  require 'active_support/core_ext/numeric/conversions'

  def message_data
    resp = JSON.parse(Net::HTTP.get(URI("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD")))

    if resp["Response"] != "Error"
      price = resp["USD"].to_f.to_i
    else
      price = -1
    end

    if price>-1
      message_data = "$#{price.to_s(:delimited)}"
    else
      message_data = "Sorry, something went wrong fetching this price."
    end

    return message_data
  end

  def send_message
    message = PricesmailerMailer.generate_message(phone: phone, carrier: carrier, price: message_data)
    message.deliver
  end
end
