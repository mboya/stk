Rails.application.routes.draw do
  root 'push#index'
  post 'payment' => 'push#payment'
  post 'callback' => 'push#callback'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
