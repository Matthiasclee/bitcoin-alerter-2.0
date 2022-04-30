class MessagesController < ApplicationController
  def incoming
    @message = Message.new(content: params[:Body], to: params[:To], from: params[:From])
    @message.save

    @user = User.find_by(phone: @message.from)
    if @user.present?
      if @message.content.downcase == 'unregister'
        @user.destroy

        render plain: "You have successfully unregistered."
      end

      if @message.content.downcase.split(" ")[0..1] == ["subscribe", "to"]
        
      end
    else
      if @message.content.downcase == 'register' 
        @user = User.new(phone: @message.from)

        if @user.save
          render plain: "You have successfully registered."
        else
          render plain: "Whoops, something went wrong, and we were not able to register you."
        end
      else
        render plain: "You are not registered. To register, reply with 'register'."
      end
    end
  end
end
