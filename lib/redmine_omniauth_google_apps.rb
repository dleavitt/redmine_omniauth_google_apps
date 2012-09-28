require 'redmine_omniauth_google_apps/setting_extension'
require 'redmine_omniauth_google_apps/user_extension'
require 'redmine_omniauth_google_apps/account_controller_extension'
require 'redmine_omniauth_google_apps/hooks'

module RedmineOmniauthGoogleApps
  def self.swap_middleware
    # TODO: figure out how to swap middleware without restarting app
    if domain = Setting['plugin_redmine_omniauth_google_apps']['domain']
      stack = Rails.application.config.middleware
      middleware = RedmineOmniauthGoogleApps::Middleware
      
      if stack.respond_to?(:include?) && stack.include?(middleware)
        stack.delete middleware 
      end
      
      stack.use middleware do
        provider :google_apps, :domain => domain
      end
      
      RedmineApp::Application.reload_routes!
    end
  end
end