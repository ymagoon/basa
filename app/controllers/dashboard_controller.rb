class DashboardController < ApplicationController
  before_action  :set_assigned_volunteers, :set_attendance_percentage, :set_active_courses, :average_attendance
  def home
    @courses = active_courses
    @no_teacher = courses_with_no_teacher
    @below_cap = Course.courses_below_min_cap
  end

  def volunteers
    @c_vols = Proficiency.teachers_by_subject("C#")
    @ruby_vols = Proficiency.teachers_by_subject("Ruby on Rails")
    @scratch_vols = Proficiency.teachers_by_subject("Scratch")
    @python_vols = Proficiency.teachers_by_subject("Python")
    @php_vols = Proficiency.teachers_by_subject("PHP")
    @mobile_app_vols = Proficiency.teachers_by_subject("Mobile App Development")
    @unassigned_vols = Proficiency.teachers_by_subject(nil)
  end

  def students
    @attending_students = number_of_students_attended_course
  end

  def attendance
  end

  private

  # Courses
  def total_number_of_courses
    Course.count
  end

  def active_courses
    @active_courses = Course.all.select { |c| c.status != 'cancelled'}
    #NEED DATE FILTER
  end

  def active_course_attendance
    total_attendance = @course.attendances.count
    total_present = @course.attendances.select { |c| c.present == "present" }.count
    @active_courses.each { |course|
      present = course.attendances.select { |c| c.present == "present" }.count
      total = course.attendances.count
      return present/total
    }
    # list all courses that are active and their corresponding % aggregate
  end

  def courses_with_no_teacher
    courses_w_teachers = VolunteerRoster.all.map { |a| a.course_id}.uniq
    ids = Course.all.ids - courses_w_teachers
    courses_with_no_teacher = ids.map { |id| Course.find(id) }
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

  def number_of_students_attended_course_unique
    # distinct number of students attended course - count students that have attended > 1 course ONCE
  end

  def total_student_attendance
    @percentage_attendance
  end

  def student_attendance_for_active_courses
    # % of student attendance for active courses - make sure the % only counts attendance UNTIL TODAY! (day running report)
    # otherwise, the data will be skewed

  end

  # Volunteers
  def total_number_of_volunteers
    User.where(role: 'volunteer').count
  end

  # MOVED TO USER MODEL
  # def number_of_volunteers_assigned_to_course
  #    # total number of volunteers
  #   users = User.where(role: 'volunteer').count

  #   #total number of distinct users on volunteer_rosters
  #   distinct_users = VolunteerRoster.select(:user_id).distinct.count

  #    @assigned_volunteers = users - distinct_users
  #   # show # of volunteers that have never been assigned to a course
  # end

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
end
