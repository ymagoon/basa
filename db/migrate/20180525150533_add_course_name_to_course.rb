class AddCourseNameToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :name, :string
  end
end
