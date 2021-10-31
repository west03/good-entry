Rails.application.routes.draw do

  devise_for :hosts, controllers: {sessions: 'hosts/devise/sessions', password: 'hosts/password',
                                   registrations: 'hosts/devise/registrations', password: 'hosts/password'}
  devise_for :guests, controllers: {sessions: 'guests/devise/sessions', password: 'guests/password',
                                    registrations: 'guests/devise/registrations', password: 'guest/password'}
  devise_for :admins, controllers: {sessions: 'admins/devise/sessions', password: 'admins/passwrd'}

  root to: 'homes#top'
  get 'about' => 'homes#about'

  scope module: :guests do
    resource :guests, only:[:edit, :update]
    get 'guests/my_page' => 'guests#show', as: 'my_page'
    get 'guests/unsubscribe' => 'guests#unsubscribe'
    patch 'guests/withdraw' => 'guests#withdraw'
    resources :hosts, only:[:index, :show]
    resources :events, only:[:index, :show]
    resources :event_entries, only:[:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :event_posts, only:[:index]
  end

  namespace :hosts do
    root to: 'homes#top'
    resources :hosts, only:[:show, :edit, :update]
    get 'hosts/unsubscribe' => 'hosts#unsubscribe'
    patch 'hosts/withdraw' => 'hosts#withdraw'
    resources :events
    resources :guests, only:[:show]
    resources :genres, except:[:new, :show]
    resources :event_posts, only:[:index]
  end

  namespace :admins do
    root to: 'homes#top'
    resources :guests, except:[:new, :careate, :destroy]
    resources :hosts, except:[:new, :careate, :destroy]
    resources :events, except:[:new, :careate, :destroy]
    resources :event_posts, only:[:index]
    resources :event_guests, only:[:index]
  end

end

