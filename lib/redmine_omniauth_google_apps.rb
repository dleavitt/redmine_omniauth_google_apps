require 'redmine_omniauth_google_apps/railtie'
require 'redmine_omniauth_google_apps/setting_extension'
require 'redmine_omniauth_google_apps/user_extension'
require 'redmine_omniauth_google_apps/account_controller_extension'

module RedmineOmniauthGoogleApps
  def self.swap_middleware
    if domain = Setting['plugin_redmine_omniauth_google_apps']['domain']
      stack = Rails.application.config.middleware
      middleware = RedmineOmniauthGoogleApps::Middleware
      
      if stack.respond_to?(:include?) && stack.include?(middleware)
        stack.delete middleware 
      end
      
      stack.use middleware do
        provider :google_apps, :domain => domain
      end
    end
  end
end