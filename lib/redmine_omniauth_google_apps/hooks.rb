module RedmineOmniauthGoogleApps
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_account_login_top, :partial => 'redmine_omniauth_google_apps/view_account_login_bottom'
  end
end