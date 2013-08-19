Manage::Engine.routes.draw do
  resources :dashboards
  resources :admin_users

  # devise_for :admin_users, skip: :registrations, controllers: {
  #   sessions: "manage/sessions",
  # }
end