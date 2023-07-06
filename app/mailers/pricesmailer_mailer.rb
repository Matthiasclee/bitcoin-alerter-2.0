class PricesmailerMailer < ApplicationMailer
  def generate_message(phone:, carrier:, price:)
    gateways = ["@vtext.com", "@txt.att.net", "@tmomail.net", "@messaging.sprintpcs.com", "@mymetropcs.com", "@sms.cricketwireless.net", "@msg.fi.google.com"]
    mail(
      from: "bitcoinalerter@matthiasclee.com",
      to: "#{phone}#{gateways[carrier]}",
      subject: "BTC",
      body: price,
      content_type: "text/plain"
    )
  end
end
