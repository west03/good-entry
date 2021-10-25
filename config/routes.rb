Rails.application.routes.draw do
  devise_for :hosts, controllers: {seessions: 'hosts/sessions', password: 'hosts/password'}
  devise_for :guests, controllers: {sessions: 'guests/sessions', password: 'guests/password'}
  devise_for :admins, controllers: {sessions: 'admins/sessions', password: 'admins/passwrd'}

end
