class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @total_number_of_courses = Course.count
    @total_number_of_students = Student.count
    @total_number_of_volunteers = User.where(role: 'volunteer')
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
