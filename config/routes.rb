Manage::Engine.routes.draw do
  devise_for :admin_users, :class_name => "AdminUser", skip: :registrations, controllers: {
    sessions: "manage/sessions"
  }

  resources :dashboards
  resources :admin_users

  root 'dashboards#index'
end
