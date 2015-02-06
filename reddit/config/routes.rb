Rails.application.routes.draw do
  
  get 'comments/show'

  get 'comments/create'

  get 'posts/show'

  get 'posts/create'

  # Try to find out the difference between resource and resources
  root 'subreddits#index'
  resource :session
  resources :users, param: :username, path: '/u'
  resources :subreddits, param: :name, path: '/r' do
    resources :posts, param: :title do 
      resources :comments
    end
  end
end
