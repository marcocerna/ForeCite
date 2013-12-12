ForeCite::Application.routes.draw do
  root to: "links#index"
  get "links/search/:q", to: "links#search"
  get "links/products/:q", to: "links#products"
  resources :links
end
