Rails.application.routes.draw do
  root 'polls#index'

  resources :polls
  post 'polls/:pid/vote' => 'polls#vote'
  get 'polls/:pid/vote/:oid' => 'polls#vote_fake' # GET won't work for voting, but we're not going to tell people that
  get 'polls/:pid/reset' => 'polls#reset'
  get 'polls/:pid/delete_options' => 'polls#delete_options'
end