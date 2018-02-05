require_dependency 'issue'

module SendNotification
  module IssuePatch
    def self.included(base)
      base.class_eval do

        safe_attributes 'recipient_email'

        after_create :check_before_send_recipient_email

        def check_before_send_recipient_email
          p extract_email_to_array(:recipient_email)
          if notify? && status_id == 7
            p "Отработало"
            p extract_email_to_array(:recipient_email)
            #TechMailer.send_status_(self)
          end
        end


        def extract_email_to_array(str)
          req = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
          str.scan(req).uniq
        end


      end
    end
  end
end
