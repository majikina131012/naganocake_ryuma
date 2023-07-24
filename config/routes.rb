Rails.application.routes.draw do
  namespace :admin do
    get 'search/search'
  end
  namespace :public do
    get 'adresses/index'
  end
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root to: 'public/homes#top'
get 'home/about' => 'public/homes#about', as: 'about'

scope module: :public do
    get '/customers/check' => 'customers#check'
    patch '/customers/withdraw' => 'customers#withdraw'
    resources :customers
    resources :items
    resources :cart_items do
      collection do
        delete 'destroy_all'
      end
    end
    resources :addresses
    get '/orders/thanks' => 'orders#thanks'
    post '/orders/confirm' => 'orders#confirm'
    resources :orders, only: [:new, :create, :index, :show]

  end

  namespace :admin do
    root to: 'homes#top'
    resources :customers
    resources :genres
    resources :items 
    resources :orders
    resources :order_details
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
