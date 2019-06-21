Rails.application.routes.draw do
  resources :stock_data, param: :symbol, only: :show
end
