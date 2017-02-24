Rails.application.routes.draw do
  get '/main' => 'users#index'

  get '/bright_ideas' => 'users#bright_ideas'

  get '/bright_ideas/:id' => 'users#bpage'

  get 'edit/:id' => 'users#edit'

  post '/update' => 'users#update'

  get '/users/:id' => 'users#users'

  get '/like/:id' => 'users#like'

  get '/unlike/:id' => 'users#unlike'

  get '/remove/:id' => 'users#remove'

  get '/logout' => 'users#logout'

  post '/post_comment/:id' => 'users#post_comment'

  post '/create' => 'users#create'

  post '/login' => 'users#login'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
