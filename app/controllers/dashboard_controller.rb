class DashboardController < ApplicationController
  before_action  :set_courses, :set_subjects, :set_students, :set_volunteers, :set_unassigned_vols, :set_attendances

  def home
    @students_by_age = @students.group_by_age
    @students_by_gender = @students.group_by_gender
    @courses_by_subject = @courses.group_by_subject
    @volunteers_by_subject = Proficiency.group_by_subject

    @total_attendance = @courses.total_attendance

    @current_attendance = @courses.active.total_attendance
    @past_attendance = @courses.past.total_attendance # fails if there is no past attendance

    @attendance_by_course = {}
    @courses.active.each { |c| @attendance_by_course[c.name] = c.course_attendance }
  end

  def statistics
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
    @courses = Course.all
    @active_courses = @courses.active
    @no_teacher = @courses.no_teacher
    @below_cap = @courses.courses_below_min_cap
  end

  def set_unassigned_vols
    @unassigned_vols = User.unassigned_vols
  end

  def set_attendances
    @course_attendance = @courses.lowest_attendance
    @students_attendance = @students.lowest_attendance
  end

  def set_students
    @students = Student.all
    @absent_students = @students.absent_student
  end

  def set_subjects
    @subjects = Subject.all
  end

  def set_volunteers
    @volunteers = User.volunteer.count
  end
end
