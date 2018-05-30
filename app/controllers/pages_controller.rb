class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @total_number_of_courses = Course.count
    @courses_last_week = @total_number_of_courses - Course.where('created_at < ?', DateTime.now - 7).count

    @total_number_of_students = Student.count
    @students_last_week = @total_number_of_students - Student.where('created_at < ?', DateTime.now - 7).count

    @total_number_of_volunteers = User.where(role: 'volunteer').count
    @volunteers_last_week = @total_number_of_volunteers - User.where('role = ? and created_at < ?', 1, DateTime.now - 7).count
  end
end


  #   def total_student_attendance
  #   @percentage_attendance
  # end

  # # Volunteers
  # def total_number_of_volunteers
  #   User.where(role: 'volunteer').count
  # end

  # def set_active_courses
  #   @active_courses = Course.all.select { |c| c.status != 'cancelled'}
  # end -->
