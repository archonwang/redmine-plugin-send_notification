require_dependency 'issue_query'

module SendNotification
  module IssueQueryPatch
    def self.included(base)
      base.class_eval do

        self.available_columns << QueryColumn.new(:recipient_email)

      end
    end
  end
end
