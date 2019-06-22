Rails.application.routes.draw do
  root 'application#not_found'
  resources :stock_data, param: :symbol, only: :show
end
