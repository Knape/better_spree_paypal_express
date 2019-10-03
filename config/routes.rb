Spree::Core::Engine.add_routes do
  post '/paypal', :to => "paypal#express", :as => :paypal_express
  get '/paypal/confirm', :to => "paypal#confirm", :as => :confirm_paypal
  get '/paypal/cancel', :to => "paypal#cancel", :as => :cancel_paypal
  get '/paypal/notify', :to => "paypal#notify", :as => :notify_paypal

  namespace :admin do
    # Using :only here so it doesn't redraw those routes
    resources :orders, :only => [] do
      resources :payments, :only => [] do
        member do
          get 'paypal_refund'
          post 'paypal_refund'
        end
      end
    end
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post '/pay/index', to: 'pay#index', as: 'pay_index'
      post '/pay/confirm', to: 'pay#confirm', as: 'pay_confirm'
    end
  end

end
