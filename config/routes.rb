Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/app/callback' => 'app_data#redirect_path'
  post '/app/initialize' => 'app_data#initialize_path'
  post '/app/submit' => 'app_data#submit_path'
end
