require "redmine_omniauth_google_apps"

Redmine::Plugin.register :redmine_omniauth_google_apps do
  name 'Redmine Omniauth Google Apps plugin'
  author 'Daniel Leavitt'
  description 'Allows login and automatic registration through a Google Apps domain'
  version '0.0.1'
  url 'https://github.com/dleavitt/redmine_omniauth_google_apps'
  author_url 'https://github.com/dleavitt'
  settings  :partial => "omniauth_google_apps",
            :default => { "domain" => '' }
end