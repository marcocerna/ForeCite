ForeCite::Application.routes.draw do
  root to: "links#index"
  get "links/search/:q", to: "links#search"
  get "links/products/:q", to: "links#products"
  get "links/boss/:q", to: "links#boss"
  resources :links
end
