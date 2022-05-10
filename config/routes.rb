Rails.application.routes.draw do
  get 'glossaries', to: 'glossaries#index'
  post 'glossaries', to: 'glossaries#create'
  get 'glossaries/:id', to: 'glossaries#show'

  post 'glossaries/:id/terms', to: 'terms#create'

  get 'translations/:id', to: 'translations#show'
  post 'translations', to: 'translations#create'
end
