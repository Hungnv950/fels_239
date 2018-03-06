class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: @user.email, subject: t("account.active")
  end

  def result_lesson user, lesson, result
    @user = user
    @lesson = lesson
    @result = result
    mail to: @user.email, subject: t("lesson.is_finised", id: @lesson.id)
  end

  def send_mail_every_months user
    @user = user
    mail to: @user.email, subject: "end month"
  end
end
