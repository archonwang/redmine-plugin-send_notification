
require_dependency 'send_notification'

module SendNotification
  module IssuePatch
    def self.included(base)
      base.class_eval do

        after_create :send_notification


        def send_notification_to_recipient
          if notify? && status_id == 7
            TechMailer.send_status_(self)
          end
        end


      end
    end
  end
end
