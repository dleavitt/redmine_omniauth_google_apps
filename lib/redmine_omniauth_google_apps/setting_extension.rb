module RedmineOmniauthGoogleApps
  module SettingExtension
    extend ActiveSupport::Concern 
  
    included do
      after_save do
        if name == 'plugin_redmine_omniauth_google_apps'
          RedmineOmniauthGoogleApps.swap_middleware
        end
      end
    end
  end
end