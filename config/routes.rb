Rails.application.routes.draw do
  root 'push#index'
  post 'payment' => 'push#payment'
  post 'callback' => 'push#callback'

  match 'validation' => 'push#till_validation', via: [:post, :get]
  match 'confirmation' => 'push#till_confirmation', via: [:post, :get]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
