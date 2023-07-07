class PricesmailerMailer < ApplicationMailer
  def generate_message(phone:nil, carrier:nil, email:nil, price:)
    gateways = ["@vtext.com", "@txt.att.net", "@tmomail.net", "@messaging.sprintpcs.com", "@mymetropcs.com", "@sms.cricketwireless.net", "@msg.fi.google.com"]
    if phone && carrier
      email_to = "#{phone}#{gateways[carrier]}"
    else
      email_to = email
    end
    mail(
      from: "bitcoinalerter@matthiasclee.com",
      to: email_to,
      subject: "BTC",
      body: price,
      content_type: "text/plain"
    )
  end
end
