class VolunteerRostersController < ApplicationController
  before_action :set_course

  def index
  end

  def show
    @volunteer_roster = VolunteerRoster.new
  end

  def new
    @roster = VolunteerRoster.new
    @volunteers = User.volunteers
    @roles = VolunteerRoster.roles
    # LATER ADD FILTER FOR VOLS WHERE THE course.subject == user's proficiency AND role == the @role selected in the form
  end

  def create

    @roster = VolunteerRoster.new(vol_roster_params)
    @roster.course = @course

    if @roster.save
      # raise
      redirect_to course_path(@course)
    else
      render :new

    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def vol_roster_params
    params.require(:volunteer_roster).permit(:course_id, :user_id, :role)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

end


