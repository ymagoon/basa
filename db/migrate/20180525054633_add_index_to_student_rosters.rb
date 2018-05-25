class AddIndexToStudentRosters < ActiveRecord::Migration[5.2]
  def change
    add_index :student_rosters, [:student_id, :course_id], unique: :true
  end
end
