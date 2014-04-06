class Emailer < ActionMailer::Base
  default from: "sun-innovation@sun-innovation.com"

  def new_record_notification(user)
    @user = user
    mail to: "maydaychaaaa@gmail.com", subject: "Success! You did it."
  end
end
