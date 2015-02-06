Rails.application.routes.draw do
  
  resources :sessions
  resources :users, param: :username, path: '/u'
end
