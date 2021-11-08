Rails.application.routes.draw do
  devise_for :hosts, controllers: {sessions: 'hosts/devise/sessions', password: 'hosts/password',
                                   registrations: 'hosts/devise/registrations'}
  devise_for :admins, controllers: {sessions: 'admins/devise/sessions', password: 'admins/passwrd'}

  root to: 'homes#top'
  get 'about' => 'homes#about'

  namespace :hosts do
    get 'hosts/unsubscribe' => 'hosts#unsubscribe', as: 'hosts_unsubscribe'
    patch 'hosts/withdraw' => 'hosts#withdraw'
    resources :hosts, only:[:show, :edit, :update]
    resources :events
    resources :guests, only:[:show]
    resources :genres, except:[:new, :show]
    resources :event_posts, only:[:index, :show]
  end

  namespace :admins do
    root to: 'events#index'
    resources :guests, except:[:new, :careate, :destroy]
    resources :hosts, except:[:new, :careate, :destroy]
    resources :events, except:[:new, :careate]
    resources :event_posts, only:[:show]
    resources :event_guests, only:[:show]
    resources :event_entries, only:[:show]
  end

 scope module: :guests do
    resource :guests, only:[:edit, :update]
    get 'guests/my_page' => 'guests#show', as: 'my_page'
    get 'guests/unsubscribe' => 'guests#unsubscribe'
    patch 'guests/withdraw' => 'guests#withdraw'
    resources :hosts, only:[:index, :show]
    resources :events, only:[:index, :show] do
      resources :likes, only:[:create, :destroy]
    end
    resources :event_entries, only:[:index, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :event_posts, only:[:show]
  end


  devise_for :guests, controllers: {sessions: 'guests/devise/sessions', password: 'guests/password',
                                    registrations: 'guests/devise/registrations'}

end