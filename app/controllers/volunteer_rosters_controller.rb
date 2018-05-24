class VolunteerRostersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
     # @volunteer = Volunteer.find(params[:id])
    # @course = Course.find(params[:id])

    if save
      #then query the session and find all sessions where course.sessions
      #loop through each sessions course.sessions.each do
      #attendance.create
      #then pass studentid in to session id and create an attendance record per session per student
      #
      #check for testing: present field needs to be defaulting to 0 (Model should be doing this)
    end

  end

  def edit
    #to change the role of the volunteer, from asst to lead or vice versa
  end

  def update
  end

  def destroy
  end
end
