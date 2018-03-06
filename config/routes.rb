Rails.application.routes.draw do
  get '/:id', to: 'shortened_urls#redirect'
  get '/surl/:id', to: 'shortened_urls#new', as: 'shortened'
  post '/surl', to: 'shortened_urls#create', as: 'shortened_urls'
  root 'shortened_urls#new'
  # resources :shortened_urls
end
