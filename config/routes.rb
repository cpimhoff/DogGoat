Rails.application.routes.draw do
  get 'members/show'

  get 'members/claim'

  get 'members/settings'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'posts#index'

  resources :posts do
    collection do
      get 'search'
    end
    member do
      get 'delete'  #delete form not default
    end
  end

  resources :members, except: [:index, :destroy], path_names: { new: "claim", edit: "settings"}

  resources :invites, except: [:show]

  get 'login' => 'login#index'
  post 'login' => 'login#login'
  get 'logout' => 'login#logout'

  # Routes for the admin zone
  mount RailsAdmin::Engine => '/admin_zone', as: 'rails_admin'

end
