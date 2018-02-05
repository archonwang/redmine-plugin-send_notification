module SendNotification
  class SendHooks < Redmine::Hook::ViewListener
    render_on(:view_issues_form_details_bottom,      :partial => 'issues/notification_email_form')
    render_on(:view_issues_show_details_bottom,      :partial => 'issues/notification_email_show')
  end
end