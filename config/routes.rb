Rails.application.routes.draw do

  resources :jobs do 
    collection do
      get 'queue/:job/:queue', as: :queue, action: :queue
      get 'reset', action: :reset, as: :reset
    end
  end

  root to: 'jobs#index'
end
