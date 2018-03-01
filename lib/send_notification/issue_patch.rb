require_dependency 'issue'

module SendNotification
  module IssuePatch


    def self.included(base)
      base.class_eval do

        safe_attributes 'recipient_email'

        after_save :check_before_send_recipient_email

        def check_before_send_recipient_email
          unless recipient_email.blank?
            issue_status_confirmed_id = Setting.plugin_send_notification["issue_status_confirmed_id"].to_i
            issue_status_completed_id = Setting.plugin_send_notification["issue_status_completed_id"].to_i
            issue_status_in_work_id = Setting.plugin_send_notification["issue_status_in_work_id"].to_i
            issue_status_in_stop_id = Setting.plugin_send_notification["issue_status_in_stop_id"].to_i
            # Task confirmed
            if notify? && (status_id_changed? && status_id == issue_status_confirmed_id)
              TechMailer.send_issue_accept(self).deliver_now
            # Task Completed
            elsif notify? && (status_id_changed? && status_id == issue_status_completed_id)
              TechMailer.send_issue_end(self).deliver_now
            #Task due date change
            elsif notify? && (start_date_changed? || due_date_changed?) &&
                (
                    status_id == issue_status_confirmed_id ||
                    status_id == issue_status_in_work_id ||
                    status_id == issue_status_in_stop_id
                )
              TechMailer.send_issue_change(self).deliver_now
            end
          end
        end
      end
    end
  end
end
