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

# root to: 'public/homes#top'
get 'home/about' => 'public/homes#about', as: 'about'

scope module: :public do
    root 'homes#top'
  
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    # ↑customers/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get '/customers/check' => 'customers#check', as: 'comfirm_unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'
    
    
    
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    
    # resources :customers
    resources :items, only: [:index, :show] 
    resources :cart_items, only: [:index,:create, :update, :destroy]
    resources :addresses
    get '/orders/thanks' => 'orders#thanks'
    post '/orders/confirm' => 'orders#confirm'
    get 'orders/confirm' => 'orders#error'
    resources :orders, only: [:new, :create, :index, :show]

  end

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    get 'customers/:customer_id/orders' => 'order#idex', as: 'customer_orders'
    
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres
    resources :items
    resources :orders, only: [:index, :show, :update] do
      resources :order_details, only: [:update]
    end  
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
