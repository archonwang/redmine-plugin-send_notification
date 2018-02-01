class AddEmailRecipientToIssue < ActiveRecord::Migration
  def change
    change_table :issues do |i|
      i.string    :recipient_email
    end
  end
end
