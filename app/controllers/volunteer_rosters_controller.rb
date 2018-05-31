class VolunteerRostersController < ApplicationController
  before_action :set_course, except: :destroy
  before_action :set_view

  def index
  end

  def show
    @volunteer_roster = VolunteerRoster.new
  end

  def new
    @roster = VolunteerRoster.new
    @teachers = list_teachers
    @assistants = list_assistants
    @volunteers = list_teachers + list_assistants
    if !params[:volunteer].nil?
      check_vol_courses
    end
  end

  def create
    @roster = VolunteerRoster.new(vol_roster_params)
    @roster.course = @course

    if @roster.save
      redirect_to new_course_volunteer_roster_path(@course)
    else
      redirect_to new_course_volunteer_roster_path(@course), :flash => { :error => "Couldn't save the assignment, try another volunteer!" }
    end
  end

  def destroy
    @roster = VolunteerRoster.find(params[:id])
    @roster.destroy
    @course = @roster.course
    redirect_to new_course_volunteer_roster_path(@course)
  end

  def check_vol_courses
    @volunteer = params[:volunteer]
    @vol_courses = VolunteerRoster.courses_by_volunteer(params[:volunteer])
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

  def set_view
    @view = "teacher"
  end
end


