class StudentRostersController < ApplicationController
  def create
    # @student = Student.find(params[:id])
    # @course = Course.find(params[:id])

    if save
      #then query the session and find all sessions where course.sessions
      #loop through each sessions course.sessions.each do
      #attendance.create
      #then pass studentid in to session id and create an attendance record per session per student
      #
      #check for testing: present field needs to be defaulting to 0 (Model should be doing this)
  end

  def destroy

    #should only be able to add and delete a link bewtween a course and a student.
    #need to make sure that attendance record is dependant destroy based on this!!!!!
  end
end
