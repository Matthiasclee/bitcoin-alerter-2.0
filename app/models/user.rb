class User < ApplicationRecord
  require 'net/http'
  require 'active_support/core_ext/numeric/conversions'

  def prices
    prices = {}

    subscribed_to.each do |c|
      resp = JSON.parse(Net::HTTP.get(URI("https://min-api.cryptocompare.com/data/price?fsym=#{c}&tsyms=USD")))
      
      if resp["Response"] != "Error"
        price = resp["USD"].to_f.to_i
        price_modified = (price * 1.05).to_i
        prices[c.to_sym] = price if !is_bad
        prices[c.to_sym] = price_modified if is_bad
      else
        prices[c.to_sym] = 0
      end
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
