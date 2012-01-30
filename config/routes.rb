Qbtoer::Application.routes.draw do
  
  resources :testmealls

  resources :quickbook_imports
  
   match 'importqwc' => "quickbook_imports#importqwc", :as => :importqwc 
   match "quickbook_import_status" => "quickbook_imports#quickbook_import_status",:as=>:quickbook_import_status
   match "clean_up_import_status" => "quickbook_imports#clean_up_import_status",:as=>:clean_up_import_status
   match "replan_import"  => "quickbook_imports#replan_import",:as=>:replan_import
   
 
  resources :qb_tags

  resources :tag_groups

  ## Dashboard
match 'apis/quickbooks/api', :controller => 'qbwc', :action => 'api'
  

   root :to => "quickbook_imports#index"
end
