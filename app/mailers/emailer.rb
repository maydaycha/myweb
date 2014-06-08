class Emailer < ActionMailer::Base
  default from: "sun-innovation@sun-innovation.com"

  def new_record_notification(user, comment)
    @comment = comment
    mail to: user.email, subject: "New comment"
  end

end
