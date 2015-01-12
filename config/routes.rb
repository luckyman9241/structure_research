Api::Application.routes.draw do
  

  
  delete "statuses/destroy/:id"=>'statuses#destroy'
  resources :statuses
  delete "analysts/destroy/:id"=>'analysts#destroy'
  resources :analysts
  
  resources :base_values, except: [:new, :edit]
  get "company_revenues/getcompanyrevenue/:compId/:year"=>'company_revenues#getcompanyrevenue'
  resources :company_revenues

  
  delete "revenues/destroy/:id"=>'revenues#destroy'
  resources :revenues
  
  delete "geos/destroy/:id"=>'geos#destroy'
  resources :geos
  
  
  get "company_geos/getbyName/:name"=>'company_geos#getbyName'
  get "company_geos/getcompanygeos/:compId/:year"=>'company_geos#getcompanygeos'
  
  resources :company_geos
  
  delete "legend_values/destroy/:id"=>'legend_values#destroy'
  resources :legend_values, except: [:new, :edit]
  
  resources :users, except: [:new, :edit]
  
  resources :user_types, except: [:new, :edit]
  
  delete "states/destroy/:id"=>'states#destroy'
  resources :states

  delete "revenue_ranges/destroy/:id"=>'revenue_ranges#destroy'
  resources :revenue_ranges

  delete "regions/destroy/:id"=>'regions#destroy'
  resources :regions

  delete "percent_ranges/destroy/:id"=>'percent_ranges#destroy'
  resources :percent_ranges

  delete "ndas/destroy/:id"=>'ndas#destroy'
  resources :ndas

  delete "legends/destroy/:id"=>'legends#destroy'
  resources :legends

  resources :investors


  delete "growths/destroy/:id"=>'growths#destroy'
  get "growths/allcompanies"=>'growths#allcompanies'
  resources :growths


  delete "countries/destroy/:id"=>'countries#destroy'
  
  resources :countries

  delete "confidence_levels/destroy/:id"=>'confidence_levels#destroy'
  resources :confidence_levels


  delete "company_types/destroy/:id"=>'company_types#destroy'
  
  resources :company_types

  resources :company_regions_growths

  resources :company_investors

  get "company_growths/filter/:comp/:year"=>'company_growths#filter'
  get "company_growths/getcompanygrowth/:compId/:year"=>'company_growths#getcompanygrowth'
  post "company_growths/api"=>'company_growths#api'
  post "company_growths/apidiff"=>'company_growths#apidiff'

  resources :company_growths

  delete "company_classifications/destroy/:id"=>'company_classifications#destroy'
  resources :company_classifications
  
  get "companies/getWidgetDetail"=>'companies#getWidgetDetail'
  get "companies/getbyId/:id"=>'companies#getbyId'
  get "companies/masterData" => 'companies#masterData'
  get "companies/getCompaniesGrowthFirst/:name/:country/:region/:year/:min/:max/:page" => 'companies#getCompaniesGrowthFirst'
  post "companies/updateCompany" => 'companies#updateCompany'

  get "companies/getbyName/:name/:country/:region/:year/:min/:max/:page/:sort/:sortIndex"=>'companies#getbyName'
  get "companies/getCompaniesGrowth/:name/:country/:region/:year/:min/:max/:page/:sort/:sortIndex" => 'companies#getCompaniesGrowth'
  get "companies/getCompaniesGeo/:name/:country/:region/:year/:min/:max/:page/:sort/:sortIndex" => 'companies#getCompaniesGeo'
  get "companies/getCompaniesRevenue/:name/:country/:region/:year/:min/:max/:page/:sort/:sortIndex" => 'companies#getCompaniesRevenue'

  delete "companies/destroy/:id"=>'companies#destroy'
  resources :companies


  delete "classifications/destroy/:id"=>'classifications#destroy'
  resources :classifications


  delete "cities/destroy/:id"=>'cities#destroy'
  resources :cities

  post "users/authenticate" => 'users#authenticate'
  resources :users


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
