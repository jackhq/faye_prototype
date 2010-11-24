FayeClient::Application.routes.draw do
  
  resources :requests do
    collection do
      get :publish
    end
  end

  root :to => "requests#index"
end
