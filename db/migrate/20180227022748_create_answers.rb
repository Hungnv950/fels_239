class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :word, foreign_key: true
      t.boolean :is_correct
      t.text :content

      t.timestamps
    end
  end
end
