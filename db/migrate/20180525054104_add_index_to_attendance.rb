class AddIndexToAttendance < ActiveRecord::Migration[5.2]
  def change
    add_index :attendances, [:student_id, :session_id], :unique => true
  end
end
