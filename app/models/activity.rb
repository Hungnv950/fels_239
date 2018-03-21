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
        "<p class='alert alert-danger'>
          <a href='categories/#{category_at.id}' target='_blank'>#{I18n.t("category.create")}
          #{I18n.t("category.category")} #{category_at.name}
            #{I18n.t("user.at")} #{created_at}</a>
        </p>".html_safe
      when "login_log"
        "<p class='alert alert-info'>
          #{I18n.t "activity.login_log", name: user_at.name, time: created_at}
        </p>".html_safe
      when "logout_log"
        "<p class='alert alert-info'>
          #{I18n.t "activity.logout_log", name: user_at.name, time: created_at}
        </p>".html_safe
      when "create_lesson"
        "<p class='alert alert-success'>
          #{I18n.t "lesson.create_lesson", name: user.name, lesson_name: lesson_at.id, time: created_at}
        </p>".html_safe
      when "doing_lesoon"
        "<p class='alert alert-success'>
          #{I18n.t "activity.doing_lesson", name: user.name, lesson_name: lesson_at.id, time: created_at}
        </p>".html_safe
      when "finished_lesson"
        "<p class='alert alert-success'>
          #{I18n.t "activity.finished_lesson", name: user.name, lesson_name: lesson_at.id, time: created_at}
        </p>".html_safe
      else
      end
  end
end
