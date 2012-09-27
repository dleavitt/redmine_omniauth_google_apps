module RedmineOmniauthGoogleApps
  module AccountControllerExtension
    extend ActiveSupport::Concern 

    included do
      skip_before_filter :protect_from_forgery, :only => [:login_omniauth]
    end

    def login_omniauth
      user = User.find_or_create_from_omniauth(request.env["omniauth.auth"])
      # TODO: add flash message
      successful_authentication(user)
    end
  end
end