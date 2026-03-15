Website::Engine.routes.draw do
  resources :enrollments, only: [:create]
  resources :applicants, only: [:new, :create]
  get "sitemap.xml", to: "sitemap#index", as: :sitemap, defaults: { format: :xml }
  root "pages#index"
end
