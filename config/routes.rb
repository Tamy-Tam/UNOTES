Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :notes do
    collection do
      get 'search'
    end
  end

  resources :notes do
    resources :favourite_note, as: :fnote
  end

  resources :ycourses, only: [:new, :create]
end
