class AddEmailRecipientToIssue < ActiveRecord::Migration
  def change
    change_table :issue do |i|
      i.string    :recipient_email
    end
  end
end
