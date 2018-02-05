require 'roadie'

class TechMailer < ActionMailer::Base

  default from: 'no-reply@redmine.lvs.onpp'


  def send_issue_accept(issue)
    @text = issue.subject
    @to = extract_email_to_array(issue.recipient_email)
    @issue = issue
    mail to: @to, subject:"Задача поставлена в план"
  end

  def send_issue_change(issue)
    @text = issue.subject
    @to = extract_email_to_array(issue.recipient_email)
    @issue = issue
    mail to: @to, subject:"Задача изменилась"
  end

  def send_issue_end(issue)
    @text = issue.subject
    @to = extract_email_to_array(issue.recipient_email)
    @issue = issue
    mail to: @to, subject:"Задача завершена"
  end

  def extract_email_to_array(str)
    req = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
    str.to_s.scan(req).uniq
  end


end
