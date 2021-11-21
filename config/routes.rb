Rails.application.routes.draw do
  devise_for :hosts, controllers: {sessions: 'hosts/devise/sessions', password: 'hosts/password',
                                   registrations: 'hosts/devise/registrations'}
  devise_for :admins, controllers: {sessions: 'admins/devise/sessions', password: 'admins/passwrd'}

  root to: 'homes#top'

  namespace :hosts do
    get  'my_page' => 'homes#top'
    get 'hosts/unsubscribe' => 'hosts#unsubscribe'
    patch 'hosts/withdraw' => 'hosts#withdraw'
    resources :hosts, only:[:index,:show, :edit, :update]
    resources :events
    resources :guests, only:[:show]
    resources :genres, except:[:new, :show]
    resources :event_posts, only:[:index, :show] do
      get 'event_post_search' => 'event_posts#event_search'
    end
    resources :event_entries, only:[:show] do
      get 'event_entry_search' => 'event_entries#search'
    end
    get 'host_search' => 'hosts#search'
    get 'event_search' => 'events#search'
    get 'event_post_search' => 'event_posts#search'
  end

  namespace :admins do
    root to: 'events#index'
    resources :guests, except:[:new, :careate, :destroy]
    resources :hosts, except:[:new, :careate, :destroy]
    resources :events, except:[:new, :careate]
    resources :event_posts, only:[:show] do
      get 'event_post_search' => 'event_posts#search'
    end
    resources :event_guests, only:[:show] do
       get 'event_guest_search' => 'event_guests#search'
    end
    resources :event_entries, only:[:show] do
      get 'event_entry_search' => 'event_entries#search'
    end
    get 'event_search' => 'events#search'
    get 'host_search' => 'hosts#search'
    get 'guest_search' => 'guests#search'
  end

 scope module: :guests do
    resource :guests, only:[:edit, :update]
    get 'my_page' => 'guests#show', as: 'my_page'
    get 'guests/unsubscribe' => 'guests#unsubscribe'
    patch 'guests/withdraw' => 'guests#withdraw'
    resources :hosts, only:[:index, :show]
    resources :events, only:[:index, :show] do
      resources :likes, only:[:create, :destroy]
      resources :comments, only:[:create, :destroy]
    end
    resources :event_entries, only:[:index, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :event_posts, only:[:show] do
      get 'event_post_search' => 'event_posts#search'
    end
    get 'event_search' => 'events#search'
    get 'host_search' => 'hosts#search'
    get 'entry_search' => 'event_entries#search'
  end


  devise_for :guests, controllers: {sessions: 'guests/devise/sessions', password: 'guests/password',
                                    registrations: 'guests/devise/registrations'}

end