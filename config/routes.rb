Rails.application.routes.draw do
  root to: 'home#index'
 
  # API
  namespace :api, format: 'json' do
    post "julias/create" => "julias#create"
  end

  get '/*path', to: 'home#index' 
end
