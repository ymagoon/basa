class DashboardController < ApplicationController
  before_action  :set_courses, :set_unassigned_vols, :set_subjects, :set_students, :set_attendances, :set_volunteers

  def home
    @students_by_age = Student.group_by_age
    @students_by_gender = Student.group_by_gender
    @courses_by_subject = Course.group_by_subject
    @volunteers_by_subject = Proficiency.group_by_subject
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

  def set_volunteers
    @volunteers = User.volunteer.count
  end
end
