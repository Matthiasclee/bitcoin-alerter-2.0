class MessagesController < ApplicationController
  def incoming
    @message = Message.new(content: params[:Body], to: params[:To], from: params[:From])
    @message.save

    @user = User.find_by(phone: @message.from)
    if @user.present?
      if @message.content.downcase == 'unregister'
        @user.destroy

        response_message = "You have successfully unregistered."
      end

      split_msg = @message.content.downcase.split(" ") 
      if split_msg[0] == "subscribe" && split_msg[1]
        tkr = split_msg[1].upcase
        if @user.subscribed_to?(tkr)
          response_message = "You are already subscribed to #{tkr}. Text 'unsubscribe #{tkr}' to unsubscribe from #{tkr}."
        else
          @user.subscribed_to << tkr
          @user.save

          response_message = "You have successfully subscribed to #{tkr}."
        end
      end

      if split_msg[0] == "unsubscribe" && split_msg[1]
        tkr = split_msg[1].upcase
        if @user.subscribed_to?(tkr)
          @user.subscribed_to.delete(tkr)
          @user.save

          response_message = "You have successfully unsubscribed from #{tkr}."
        else
          response_message = "You are not subscribed to #{tkr}. Text 'subscribe #{tkr}' to subscribe to #{tkr}."
        end
      end

      if split_msg[0] == "p" || split_msg[0] == "price"
        response_message = @user.message_data
      end

      if split_msg[0] == "help."
        response_message = "Bitcoin Alerter\n\nCommands:\nsubscribe [ticker] - add [ticker] to your price updates\nunsubscribe [ticker] - remove [ticker] from your price updates\nprice - get an on-demand price update\nregister - register for Bitcoin Alerter (you are already registered)\nunregister - unregister from Bitcoin Alerter\ntoggle hourly messages - toggle hourly updates\nstart/end [hour] - start or end messages at a certain hour\nhelp. - show this"
      end

      if split_msg[0] + split_msg[1].to_s + split_msg[2].to_s == "togglehourlymessages"
        @user.send_hourly_messages = !@user.send_hourly_messages
        response_message = "Success" if @user.save
      end

      if split_msg[0] == "start" && split_msg[1]
        @user.start_messages_at = split_msg[1].to_i.to_s
        response_message = "Success" if @user.save
      end

      if split_msg[0] == "end" && split_msg[1]
        @user.end_messages_at = split_msg[1].to_i.to_s
        response_message = "Success" if @user.save
      end
    else
      if @message.content.downcase == 'register' 
        @user = User.new(phone: @message.from)

        if @user.save
          response_message = "You are now registered. Text \"help.\" for help. Text \"unregister\" to unregister."
        else
          response_message = "Whoops, something went wrong, and we were not able to register you."
        end
      else
        response_message = "You are not registered. To register, reply with 'register'."
      end
    end

    @message = Message.new(content: response_message, to: params[:From], from: params[:To])
    @message.save

    render plain: response_message
  end
end
