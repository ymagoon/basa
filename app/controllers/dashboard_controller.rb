class DashboardController < ApplicationController
  before_action  :set_active_courses, :set_courses, :set_unassigned_vols, :set_subjects, :set_students, :set_attendances

  def home
  end

  def statistics
    @teachers = User.all

    @proficiencies
    @users = User.all
  end

 def statistics
  @total_number_of_courses = Course.all
  # @courses_last_week = @total_number_of_courses.count - @total_number_of_courses.last_week.count
  @total_number_of_students = Student.all
  # @students_last_week = @total_number_of_students.count - @total_number_of_students.last_week.count
  @total_number_of_volunteers = User.volunteer.count
  # @volunteers_last_week = @total_number_of_volunteers.count - @total_number_of_volunteers.last_week.count




  # @courses_last_week = @total_number_of_courses - Course.where('created_at < ?', DateTime.now - 7).count

  #   @total_number_of_students = Student.count
  #   @students_last_week = @total_number_of_students - Student.where('created_at < ?', DateTime.now - 7).count

  #   @total_number_of_volunteers = User.where(role: 'volunteer').count
  #   @volunteers_last_week = @total_number_of_volunteers - User.where('role = ? and created_at < ?', 1, DateTime.now - 7).count
  # @teachers = User.all

  # @proficiencies
  # @subjects = Subject.all
  # @users = User.all

  @students_group_by_age = @total_number_of_students.group_by_age
  @students_group_by_gender = @total_number_of_students.group_by_gender
 end

  private


  def number_of_students_attended_course
    # number of students that have attended a course (count the student_roster table)
    a = Attendance.where(present: "present")
    @attending_students = a.map { |a| Student.find(a.student_id) }.uniq
  end

  def total_student_attendance
    @percentage_attendance
  end



  def set_courses
    @active_courses = Course.active_courses
    @courses = Course.all
    @no_teacher = Course.no_teacher
    @below_cap = Course.courses_below_min_cap
  end

  def set_unassigned_vols
    @unassigned_vols = User.unassigned_vols
  end

  def set_attendances
    @course_attendance = Course.lowest_attendance
    @students_attendance = Student.lowest_attendance
  end

  def set_students
    @students = Student.all
    @absent_students = Student.absent_student
  end

  def set_subjects
     @subjects = Subject.all
  end
end
