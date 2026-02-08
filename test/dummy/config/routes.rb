Rails.application.routes.draw do
  mount FinePrint::Engine, at: "/"

  root to: "home#index"

  post "test_sign_in", to: "sessions#create"
end
