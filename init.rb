#require 'redmine'

#require_dependency 'send_notification_hook'
#require_dependency 'issue_query_send_notification_patch'
#IssueQuery.send(:include, SendNotification::IssueQueryPatch)

if (Rails.env == 'development')
  ActiveSupport::Dependencies.autoload_once_paths.reject!{|x| x =~ /^#{Regexp.escape(File.dirname(__FILE__))}/}
end


#require_dependency 'send_notification/issue_query_send_notification_patch.rb'

IssueQuery.send(:include, SendNotification::IssueQueryPatch)
Issue.send(:include, SendNotification::IssuePatch)



require 'send_notification/send_hooks'

#SendNotification::ViewHooks
#require_dependency 'issue_send_notification_patch'

Redmine::Plugin.register :send_notification do
  name 'Send Notification plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  requires_redmine version_or_higher: '3.4'
end

