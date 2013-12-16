ForeCite::Application.routes.draw do
  root to: "links#index"
  get "links/search/:q",        to: "links#search"
  get "links/products/:q",      to: "links#products"
  get "links/boss/:q",          to: "links#boss"
  get "links/amazon_search/:q", to: "links#amazon_search"
  resources :links
end
