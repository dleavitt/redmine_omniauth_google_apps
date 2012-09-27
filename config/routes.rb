# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
RedmineApp::Application.routes.draw do
  match 'auth/:provider/callback', :to => 'account#login_omniauth'
end