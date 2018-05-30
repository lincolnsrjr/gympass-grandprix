Rails.application.routes.draw do

  root    'races#index', as: 'races_index'

  get     'corridas/:id', to: 'races#info', as: 'races_info'
  post    'races', to: 'races#create', as: 'races_create'

end
