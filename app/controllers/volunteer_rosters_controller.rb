class VolunteerRostersController < ApplicationController
  before_action :set_course, except: :destroy

  def new
    @roster = VolunteerRoster.new
    @volunteers = User.volunteers
    @roles = VolunteerRoster.roles
  end

  # TO DO
      # 1. Can't assign the same volunteer more than once
      # 2. Only one teacher per course??
      # 3. Filter the volunteers list based on proficiency LATER ADD FILTER FOR VOLS WHERE THE course.subject == user's proficiency AND role == the @role selected in the form

  def create
    @roster = VolunteerRoster.new(vol_roster_params)
    @roster.course = @course

    if @roster.save
      redirect_to course_path(@course)
    else
      render :new
    end
  end

  def destroy
    @roster = VolunteerRoster.find(params[:id])
    @roster.destroy
    @course = @roster.course
    redirect_to course_path(@course)
  end

  private

  def vol_roster_params
    params.require(:volunteer_roster).permit(:course_id, :user_id, :role)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end


