Rails.application.routes.draw do

  resources :jobs do 
    # Since rails likes to stick :job_id between things for members
    # work around here is indicate we are a collection 
    # thuse we just get /jobs
    collection do 
      get 'queue/:job/:queue', as: :queue, action: :queue
      get 'reset', action: :reset, as: :reset
    end
  end

  root to: 'jobs#index'
end
