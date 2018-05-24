class StudentRostersController < ApplicationController
  #after create, check to see if the number of studnets in the course is > min, if so, change the
  # course status to 1 (confirmed)

  skip_before_action :verify_authenticity_token, only: [:create]

#pull csrf toek from the header page and pass it in the head of the request

  def show
    @students = Student.all #need to order by what fits best
    @student = Student.find(params[:id])
    @course = Course.find(params[:id])
  end

  def create
    puts params
    @students = Student.all #need to order by what fits best
    @student = Student.find(params[:student_id])
    @course = Course.find(params[:course_id])
    @student_roster = StudentRoster.new(student: @student, course: @course)

    @student_roster.save
      # redirect_to ''
    # else
      # render 'new'
    # end

      #then query the session and find all sessions where course.sessions
      #loop through each sessions course.sessions.each do
      #attendance.create
      #then pass studentid in to session id and create an attendance record per session per student
      #
      #check for testing: present field needs to be defaulting to 0 (Model should be doing this)
  end

  private

  # def destroy
  #   @student_roster = StudentRoster.find(params[:id])
  #   if @student_roster.delete
  #     #need to figure out how to delete all the attendances we created when we destroy the roster as well. Where do I put the dependant destroy?

  #     redirect_to ???
  #   else
  #     render 'new'
  #   end
  #   #should only be able to add and delete a link bewtween a course and a student.
  #   #need to make sure that attendance record is dependant destroy based on this!!!!!
  # end
end
