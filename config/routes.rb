Simpler.application.routes do
  get '/tests', 'tests#index'
  get '/tests/:test_id/questions/:id', 'tests#show'
  get '/tests/:id', 'tests#show'
  post '/tests', 'tests#create'
end
