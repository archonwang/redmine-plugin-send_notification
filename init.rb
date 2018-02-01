#require 'redmine'

#require_dependency 'send_notification_hook'


Redmine::Plugin.register :send_notification do
  name 'Send Notification plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  requires_redmine version_or_higher: '3.4'

end

