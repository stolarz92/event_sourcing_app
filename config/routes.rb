Rails.application.routes.draw do
  post 'users/create', to: 'users#create'
  delete 'users/destroy', to: 'users#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
