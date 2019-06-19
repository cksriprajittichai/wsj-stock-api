Rails.application.routes.draw do
  root 'stock_data#show'
  resources :stock_data, param: :symbol, only: :show
end
