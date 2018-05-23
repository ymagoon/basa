class CreateStudentRosters < ActiveRecord::Migration[5.2]
  def change
    create_table :student_rosters do |t|
      t.references :student_id, foreign_key: true
      t.references :course_id, foreign_key: true

      t.timestamps
    end
  end
end
