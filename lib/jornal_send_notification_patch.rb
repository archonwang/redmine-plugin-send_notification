require_dependency 'send_notification'

module SendNotification
  module JournalPatch
    def self.included(base)
      base.class_eval do

        after_commit :send_notification, :on => :create

        def send_notification_to_recipient
          issue = self.journalized
          # Задача подверждена
          if notify? && (issue.status_id_changed? && issue.status_id == 7)
            TechMailer.issu(self)
          end
          # Задача завершилась
          if notify? && (issue.status_id_changed? && issue.status_id == 5)
            TechMailer.deliver_to_recipient(self)
          end
          # Сроки изменены
          if notify? && (issue.start_date_changed? || issue.due_date_changed?)
            TechMailer.deliver_to_recipient(self)
          end
        end


      end
    end
  end
end
