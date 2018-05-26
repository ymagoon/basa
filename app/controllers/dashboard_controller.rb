class DashboardController < ApplicationController
  def home

  end

  private

  # Courses
  def total_number_of_courses
    Course.count
  end

  def active_course_attendance
    courses = Course.where(start_date: )

Comment.where(:created_at => @selected_date.beginning_of_day..@selected_date.end_of_day)
    1.week.ago..Date.today
    # list all courses that are active and their corresponding % aggregate
  end

  def courses_with_no_teacher
    # courses that contain students that do not have a teacher assigned
  end

  def courses_below_min_capacity
  end

  # Students
  def total_number_of_students
  end

  def number_of_students_attended_course
    # number of students that have attended a course (count the student_roster table)
  end

  def number_of_students_attended_course_unique
    # distinct number of students attended course - count students that have attended > 1 course ONCE
  end

  def total_student_attendance
    # average student attendance for the entire system
  end

  def student_attendance_for_active_courses
    # % of student attendance for active courses - make sure the % only counts attendance UNTIL TODAY! (day running report)
    # otherwise, the data will be skewed
  end

  # Volunteers
  def total_number_of_volunteers
    User.where(role: 'volunteer')
  end

  def number_of_volunteers_by_proficiency
  end

  def number_of_volunteers_assigned_to_course
    # total number of volunteers
    users = User.where(role: 'volunteer').count

    #total number of distinct users on volunteer_rosters
    distinct_users = VolunteerRoster.select(:user_id).distinct.count

    users - distinct_users
  end
end
