Dummy::Application.routes.draw do
  get "orders/index"
  get "orders/change_root"
  get "orders/change_total"
  get "orders/with_method"
  get "orders/only_and_method"
  get "orders/except_and_method"
  get "orders/index_with_nested_resource"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  
  match 'orders/:id/edit' => 'orders#edit'
  match 'orders/:id/edit_change_root' => 'orders#edit_change_root'
  match 'orders/:id/edit_with_method' => 'orders#edit_with_method'
  match 'orders/:id/edit_only_and_method' => 'orders#edit_only_and_method'
  match 'orders/:id/edit_except_and_method' => 'orders#edit_except_and_method'
  match 'orders/:id/edit_with_nested_resource' => 'orders#edit_with_nested_resource'
  
  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
