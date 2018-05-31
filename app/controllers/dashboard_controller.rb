class DashboardController < ApplicationController
  before_action  :set_assigned_volunteers, :set_attendance_percentage, :set_active_courses, :set_courses, :set_unassigned_vols, :set_subjects, :set_absent_students, :set_attendances

  def home
  end

 def statistics
  @teachers = User.all
  @students = Student.all
  @proficiencies
  @users = User.all
 end

  private

  # Courses
  def total_number_of_courses
    Course.count
  end

  # Students
  def total_number_of_students
    Student.count
  end

  def number_of_students_attended_course
    # number of students that have attended a course (count the student_roster table)
    a = Attendance.where(present: "present")
    @attending_students = a.map { |a| Student.find(a.student_id) }.uniq
  end

  def total_student_attendance
    @percentage_attendance
  end

  # Volunteers
  def total_number_of_volunteers
    User.where(role: 'volunteer').count
  end

  def set_active_courses
    @active_courses = Course.all.select { |c| c.status != 'cancelled'}
  end


  def set_attendance_percentage
    total = Attendance.all.count
    present = Attendance.where(present: "present").count
    @percentage_attendance = present.to_f / total
  end

  def set_assigned_volunteers
    users = User.where(role: 'volunteer').count

    #total number of distinct users on volunteer_rosters
    distinct_users = VolunteerRoster.select(:user_id).distinct.count

    @assigned_volunteers = users - distinct_users
  end

  def set_courses
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

  def set_absent_students
    @absent_students = Student.absent_student
  end

  def set_subjects
     @subjects = Subject.all
  end
end
