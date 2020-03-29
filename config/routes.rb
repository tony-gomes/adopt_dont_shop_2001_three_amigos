Rails.application.routes.draw do
  root 'shelters#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters/', to: 'shelters#create'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:id/pets', to: 'shelterpets#index'
  get '/shelters/:shelter_id/pets/new', to: 'shelterpets#new'
  post '/shelters/:shelter_id/pets/', to: 'shelterpets#create'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id/reviews/', to: 'reviews#create'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#destroy'

  get '/pet_applications/new', to: 'pet_applications#new'
  post '/pet_applications', to: 'pet_applications#create'

  get '/favorites', to: 'favorites#index'
  post '/favorites/:pet_id', to: 'favorites#create'
  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites', to: 'favorites#destroy'
  
end
