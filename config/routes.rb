Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  patch '/notes/:id/save_content', to:'notes#save_content'
  post 'notes/:id/toggle_favorite', to: "notes#toggle_favorite", as: :toggle_favorite
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :notes do
    collection do
      get 'search'
    end
  end

  resources :ycourses, only: [:new, :create, :destroy]

  resources :favourite_notes, as: :fnote

  get '/tagged', to: "notes#tagged", as: :tagged
end
