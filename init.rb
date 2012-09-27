require "redmine_omniauth_google_apps"

Redmine::Plugin.register :redmine_omniauth_google_apps do
  name 'Redmine Omniauth Google Apps plugin'
  author 'Daniel Leavitt'
  description 'Allows login and automatic registration through a Google apps domain'
  version '0.0.1'
  url 'https://github.com/dleavitt/redmine_omniauth_google_apps'
  author_url 'https://github.com/dleavitt'
  settings  :partial => "omniauth_google_apps",
            :default => { "domain" => '' }
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, :domain => "hyfn.com"
end

module RedmineOmniauthGoogleApps
  class Railtie < ::Rails::Railtie
    config.to_prepare do
      # have to do this for some reason
      Project
      
      AccountController.send :include, GoogleAppsOmniauthLogin
      User.send :include, GoogleAppsOmniauthUser
    end
  end
end
# 
# RedmineApp::Application.after_initialize do
#   Project # autoload fails otherwise
#   # add mixins
# 
# end