require_dependency 'issue'

module SendNotification
  module IssuePatch

    ISSUE_STATUS_CONFIRMED = 7
    ISSUE_STATUS_COMPLETED = 5
    ISSUE_STATUS_IN_WORK = 2
    ISSUE_STATUS_IN_STOP = 8

    def self.included(base)
      base.class_eval do

        safe_attributes 'recipient_email'


        after_save :check_before_send_recipient_email

        def check_before_send_recipient_email
          unless recipient_email.blank?

            # Задача подверждена
            if notify? && (status_id_changed? && status_id == ISSUE_STATUS_CONFIRMED)
              TechMailer.send_issue_accept(self).deliver_now
            # Задача завершилась
            elsif notify? && (status_id_changed? && status_id == ISSUE_STATUS_COMPLETED)
              TechMailer.send_issue_end(self).deliver_now
            # Сроки изменены
            elsif notify? && (start_date_changed? || due_date_changed?) &&
                (status_id == ISSUE_STATUS_CONFIRMED || status_id == ISSUE_STATUS_IN_WORK || status_id == ISSUE_STATUS_IN_STOP)
              TechMailer.send_issue_change(self).deliver_now
            end
          end
        end
      end
    end
  end
end
