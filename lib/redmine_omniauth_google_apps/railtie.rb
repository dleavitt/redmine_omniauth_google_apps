module RedmineOmniauthGoogleApps
  class Railtie < ::Rails::Railtie
    config.to_prepare do
      # have to do this to keep autoload from breaking
      Project
      
      Setting.send :include, SettingExtension
      User.send :include, UserExtension
      AccountController.send :include, AccountControllerExtension
    end
  end
end