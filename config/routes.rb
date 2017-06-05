Rails.application.routes.draw do


  devise_for :users, 
        controllers: {
          sessions: 'front/users/sessions',
          registrations: 'front/users/registrations'
        }, 
        path: '', 
        path_names: { 
          sign_in: 'login', 
          sign_out: 'logout', 
          sign_up: 'register', 
          edit: 'profile' 
        }
  
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # scope path: ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    namespace :admin do
    	get '', to: 'dashboard#index', as: '/'
      get 'localize', to: 'locale#localize'

      namespace :settings do
        get '', to: 'dashboard#index', as: '/'
        resources :general_settings, except: :show
        resources :cities, except: :show
      end
    	resources :pages, except: :show
      resources :posts, except: :show
      resources :page_categories, except: :show
      resources :post_categories, except: :show
      resources :users, except: :show
      resources :shops, except: :show
      resources :restaurants, except: :show
      resources :labels, except: :show
      resources :sublabels, except: :show
      resources :categories, except: :show
      resources :manufacturers, except: :show
      resources :products, except: :show
      resources :faqs, except: :show
      resources :pictures, except: :show
      resources :recipes, except: :show
      resources :recipe_categories, except: :show
    end
  # end

  scope module: :front do
    root "static_pages#root"
    # get 'categories', to: 'page_categories#index'
    # resources :pages, only: [:index, :show]
    resources :page_categories, only: [:index, :show] do
      resources :pages, only: [:index, :show]
    	# Page.where.not(slug: nil).all.each do |page|
    	# 	get "/#{page.slug}", controller: "pages", action: "show", id: page.id
    	# end
    end

    resources :posts, only: [:index, :show]
    resources :post_categories, only: [:index, :show] do
      resources :posts, only: [:index, :show]
      # Page.where.not(slug: nil).all.each do |page|
      #   get "/#{page.slug}", controller: "pages", action: "show", id: page.id
      # end
    end

    resources :labels, only: [:index, :show]

    resources :products, only: [:index, :show]
    resources :categories, only: [:index, :show] do
      resources :products, only: [:index, :show]
    end

    resources :shops, only: [:index, :show]
    resources :restaurants, only: [:index, :show]
    resources :cities, only: [:index, :show] do
      resources :shops, only: [:index, :show]
      resources :restaurants, only: [:index, :show]
    end

    resources :recipes, only: [:index, :show]
    resources :recipe_categories, only: [:index, :show] do
      resources :recipes, only: [:index, :show]
    end

    resources :faqs, only: [:index]

    get '/about', to: 'general_settings#list'

    # constraints subdomain: :api do
      scope module: :api do
        namespace :v1, defaults: { format: :json } do
          resources :shops, only: [:index, :show]
          resources :restaurants, only: [:index, :show]
          resources :cities, only: [:index, :show] do
            resources :shops, only: [:index, :show]
            resources :restaurants, only: [:index, :show]
          end

          resources :posts, only: [:index, :show]
          resources :post_categories, only: [:index, :show] do
            resources :posts, only: [:index, :show]
          end

          resources :labels, only: [:index, :show]

          resources :recipes, only: [:index, :show]
          resources :recipe_categories, only: [:index, :show] do
            resources :recipes, only: [:index, :show]
          end

          resources :faqs, only: [:index]

          get '/about', to: 'general_settings#list'

          resources :products, only: [:index, :show]
          resources :categories, only: [:index, :show] do
            resources :products, only: [:index, :show]
          end

          resources :manufacturers, only: [:index, :show]
        end
      end
    # end
  end

  # match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), via: [:get]
  # match '', to: redirect("/#{I18n.default_locale}"), via: [:get]

end
