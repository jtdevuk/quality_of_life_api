Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/places/:id", to: "places#show", as: "place"
  get "/shortlist", to: "pages#shortlist", as: "shortlist"
end