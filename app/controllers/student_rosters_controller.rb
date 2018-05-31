class StudentRostersController < ApplicationController
  #after create, check to see if the number of studnets in the course is > min, if so, change the
  # course status to 1 (confirmed)
  before_action :set_course, only: [:index, :create]
  before_action :set_view

  skip_before_action :verify_authenticity_token, only: [:create]

#pull csrf token from the header page and pass it in the head of the request

  def index
    @allstudents = Student.all
    @inclass = StudentRoster.joins(:student).where(course: @course).pluck(:student_id)
    @students = @allstudents.where.not(id: @inclass).order(:created_at)

    @search = params[:search] ? true : false
    if @search
      @students = @students.where("first_name ilike ? OR last_name ilike ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @students
    end
  end

  def create
    @allstudents = Student.all
    @inclass = StudentRoster.joins(:student).where(course: @course).uniq
    @students = @allstudents - @inclass

    @student = Student.find(params[:student_id])

    @student_roster = StudentRoster.new(student: @student, course: @course)

    unless @student_roster.save
      respond_to do |format|
        format.js { flash.now[:notice] = "#{@student_roster.errors.full_messages[0]}" }
      end
    end
  end

  def destroy
    @roster = StudentRoster.find(params[:id])
    @roster.destroy
    @course = @roster.course
    redirect_to course_student_rosters_path(@course)
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_view
    @view = "student"
  end

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
