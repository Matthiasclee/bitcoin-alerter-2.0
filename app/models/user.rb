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
      prices[c.to_sym] = 0
    end

    return prices
  end

  def message_data
    dat = ""

    prices.each do |p|
      dat << "#{p[0]}: $#{p[1].to_s(:delimited)}\n"
    end

    return dat.chomp
  end

  def send_message
    if (start_messages_at.to_i..end_messages_at.to_i).include?(Time.now.strftime("%H").to_i) && send_hourly_messages
      TFA::Twilio.send_msg(message_data, to: phone)
      @message = Message.new(content: message_data, to: phone, from: ENV["TWILIO_SENDING_PHONE"])
      @message.save
    end
  end

  def subscribed_to?(a)
    subscribed_to.include?(a)
  end
end
