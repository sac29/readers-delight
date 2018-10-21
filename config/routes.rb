Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' =>'articles#index'
  post '/sign_up' => 'users#sign_up'
  get '/login' => 'users#login'
  get '/home' => 'users#index'
  post '/fetch_articles' => 'articles#fetch_articles'

end
