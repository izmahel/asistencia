Rails.application.routes.draw do
  scope(:path_names => { :new => "nueva", :edit => "editar" }) do
    resources :schedules, :path => 'citas'
  end
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/logout' => 'sessions#destroy'
  get '/login' => 'sessions#login'

  get '/administrar/:id' => 'departments#show'
  get '/administrar/:id/:date' => 'departments#show'
  post '/administrar/guardar' => 'schedules#save'

  get '/administrar-empleados' => 'schedules#employees' 
  post '/toggle-course' => 'schedules#toggle_course'
  post '/toggle-unlimited' => 'schedules#toggle_unlimited'
  post '/toggle-vulnerable' => 'schedules#toggle_vulnerable'
  post '/generar-entrada' => 'schedules#generate_unlimited'

  get '/mis-entradas' => 'schedules#my_schedules'
  post '/guardar-verificacion' => 'schedules#save_checklist'

  get '/registro' => 'schedules#register'
  get '/registro/login' => 'schedules#register_login'
  post '/registro/iniciar-sesion' => 'schedules#register_do_login'
  get '/registro/logout' => 'schedules#register_logout'
  get '/registro/ver/:date' => 'schedules#register'
  get '/registro/entradas' => 'schedules#register_in'
  get '/registro/salidas' => 'schedules#register_out'
  get '/registro/entrada/:id' => 'schedules#check_in'
  post '/registro/guardar-entrada' => 'schedules#save_in'
  get '/registro/salida/:id' => 'schedules#save_out'

  get '/ocupacion' => 'schedules#occupation'
  
  root :to => 'schedules#index'
end
