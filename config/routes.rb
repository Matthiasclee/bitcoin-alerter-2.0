Rails.application.routes.draw do
  get '/messages/incoming', to: 'messages#incoming'
end
