class VolunteerRostersController < ApplicationController
  before_action :set_course, except: :destroy

  def new
    @roster = VolunteerRoster.new
    @teachers = list_teachers
    @assistants = list_assistants
  end

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

  def list_teachers
    proficiencies = Proficiency.teachers_by_subject(@course.subject.name)
    @teachers = proficiencies.map { |proficiency| proficiency.user }
  end

  def list_assistants
    proficiencies = Proficiency.assistants_by_subject(@course.subject.name)
    @assistants = proficiencies.map { |proficiency| proficiency.user }
  end

end


