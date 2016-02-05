class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def delete_email(user)
    @user = user 
    @url = ""
    mail(:to => user.email, :subject => "Your Account has been deleted")
  end
end
