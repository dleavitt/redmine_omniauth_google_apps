# extend accounts controller model to allow login/registration via omniauth
module GoogleAppsOmniauthLogin
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

# extend user model to allow login/registration via omniauth
module GoogleAppsOmniauthUser
  extend ActiveSupport::Concern 
  
  module ClassMethods
    
    # grab part before the "@" and strip out invalid chars
    def email_to_login(email)
      email.split('@')[0].gsub(/[^a-z0-9_\-@\.]/i, "")
    end
    
    # find a user based on email or login
    def find_for_google_apps_oauth(hash)
      email = hash[:info][:email]
      User.find_by_mail(email) || User.find_by_login(email_to_login(email))
    end
    
    def find_or_create_from_omniauth(hash)
      # generate login from email
      unless user = find_for_google_apps_oauth(hash)
        user = User.new
        user.populate_from_google_apps(hash)
        # TODO: make this softer and show errors?
        user.save!
      end
      
      user
    end
  end
  
  def populate_from_google_apps(hash)
    self.tap do |u|
      u.attributes = {
        :mail         => hash[:info][:email],
        :firstname    => hash[:info][:first_name],
        :lastname     => hash[:info][:last_name],
        # automatically activates them, that ok?
        :status       => User::STATUS_ACTIVE,
      }

      u.login = self.class.email_to_login(hash[:info][:email])
      u.password = SecureRandom.hex
      u.admin = false
    end
  end
end