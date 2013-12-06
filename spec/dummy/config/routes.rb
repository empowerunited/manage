Rails.application.routes.draw do

  mount Manage::Engine => "/manage"

  Manage::Engine.routes.draw do
    resources :users
    resources :posts
  end

end
