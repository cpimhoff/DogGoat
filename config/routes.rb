Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'posts#index'

  resources :posts do
    member do
      get 'delete'  #delete form not default
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

end
