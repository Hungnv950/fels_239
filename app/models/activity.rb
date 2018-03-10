class Activity < ApplicationRecord
  belongs_to :user

  enum action_type: [:login_log, :logout_log, :create_lesson, :doing_lesoon, :finished_lesson]

  def view_activities
    @user_at = User.find_by(id: self.user_id)
    @lesson_at = Lesson.find_by id: self.target_id
    case self.action_type
      when "login_log"
        I18n.t("user.user") +" "+ @user_at.name.to_s + I18n.t("user.logged_in")+" "+I18n.t("user.at")+" "+ self.created_at.to_s
      when "logout_log"
        I18n.t("user.user") +" "+ @user_at.name.to_s + I18n.t("user.logged_out")+" "+I18n.t("user.at")+" "+ self.created_at.to_s
      when "create_lesson"
        I18n.t("user.user") +" "+ @user_at.name.to_s + I18n.t("user.created") + I18n.t("lesson.lesson")+ @lesson_at.id.to_s + I18n.t("user.at")+" "+ self.created_at.to_s
      when "doing_lesoon"
        I18n.t("user.user") +" "+ @user_at.name.to_s + I18n.t("lesson.doing") + I18n.t("lesson.lesson")+ @lesson_at.id.to_s + I18n.t("user.at")+" "+ self.created_at.to_s
      else
        I18n.t("user.user") +" "+ @user_at.name.to_s + I18n.t("lesson.finished") + I18n.t("lesson.lesson")+ @lesson_at.id.to_s + I18n.t("user.at")+" "+ self.created_at.to_s
      end
  end
end
