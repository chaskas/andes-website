Website::Engine.routes.draw do
  resources :enrollments, only: [:create]
  root "pages#index"
end
