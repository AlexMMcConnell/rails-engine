Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do

      get "/merchants/find", to: "merchants#find"
      resources :merchants do
        get "/items", to: "merchant_items#index"
      end

      get "/items/find_all", to: "items#find"
      resources :items do
        get "/merchant", to: "item_merchants#index"
      end
    end
  end
end
