Rails.application.routes.draw do
  

  # Try to find out the difference between resource and resources
  root 'subreddits#index'
  resource :session
  resources :users, param: :username, path: '/u'
  resources :subreddits, param: :name, path: '/r' do
    resources :posts, param: :title do 
      resources :comments
      get 'upvote', to: 'votes#up', on: :member
      get 'downvote', to: 'votes#down', on: :member
    end
  end
end
