class UpdateDateColumnsInCourses < ActiveRecord::Migration[5.2]
  def change
    change_column :courses, :start_date, :datetime
    change_column :courses, :end_date, :datetime
  end
end
