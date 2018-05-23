class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.references :course, foreign_key: true
      t.date :date, null: false
      t.text :notes

      t.timestamps
    end
  end
end
