Website::Engine.routes.draw do
  resources :enrollments, only: [:create]
  get "trial-classes", to: "trial_classes#index", as: :trial_classes
  resources :applicants, only: [:new, :create]
  get "impressum", to: "pages#impressum", as: :impressum
  get "datenschutz", to: "pages#datenschutz", as: :datenschutz
  get "sitemap.xml", to: "sitemap#index", as: :sitemap, defaults: { format: :xml }
  root "pages#index"
end
