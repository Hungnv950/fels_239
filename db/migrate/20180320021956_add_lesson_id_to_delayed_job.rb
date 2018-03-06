class AddLessonIdToDelayedJob < ActiveRecord::Migration[5.1]
  def self.up
    change_table :delayed_jobs do |t|
      t.integer :lesson_id
    end
  end
end
