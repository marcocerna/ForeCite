ForeCite::Application.routes.draw do
  root to: "links#index"
  get "links/search/:q", to: "links#search"
  resources :links
end
