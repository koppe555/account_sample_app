Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'users#index'
  get 'search_result', to: 'users#index'
  post 'search_result', to: 'users#search_result'
end
