class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.references :subject, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :frequency
      t.integer :number_of_sessions
      t.references :address, foreign_key: true
      t.integer :min_capacity
      t.integer :max_capacity
      t.text :notes
      t.integer :session_length
      t.integer :status

      t.timestamps
    end
  end
end
