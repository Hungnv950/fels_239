class Activity < ApplicationRecord
  belongs_to :user

  enum action_type: [:login_log, :logout_log, :create_lesson,
    :doing_lesoon, :finished_lesson, :new_category]

  def view_activities
    user_at = User.find_by(id: self.user_id)
    lesson_at = Lesson.find_by id: self.target_id
    case self.action_type
      when "new_category"
        category_at = Category.find_by id: self.target_id
        I18n.t("category.category") +" "+ category_at.name.to_s + I18n.t("lesson.created")+" "+I18n.t("user.at")+" "+ self.created_at.to_s
      when "login_log"
        I18n.t("activity.login_log", name: user_at.name, time: created_at)
      when "logout_log"
        I18n.t("activity.logout_log", name: user_at.name, time: created_at)
      when "create_lesson"
        I18n.t("lesson.create_lesson", name: user.name, lesson_name: lesson_at.id, time: created_at)
      when "doing_lesoon"
        I18n.t("activity.doing_lesson", name: user.name, lesson_name: lesson_at.id, time: created_at)
      else
        I18n.t("activity.finished_lesson", name: user.name, lesson_name: lesson_at.id, time: created_at)
      end
  end
end
