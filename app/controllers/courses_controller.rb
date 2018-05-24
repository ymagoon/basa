class CoursesController < ApplicationController
  before_action :set_subject, only: [:create]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
    @subjects = Subject.all
    @addresses = Address.all.select { |address| address.venue? }.map { |address| address.id } # Can refactor this using scope in model. See VolunteerRoster.
  end

  def create
    @course = Course.new(course_params)

    @subject = Subject.find(course_params[:subject_id])
    @course.subject = @subject

    @address = Address.find(course_params[:address_id])
    @course.address = @address

    if @course.save
      redirect_to courses_path
      # redirect_to action: course_sessions_path(@course), occurrences: @course.list_occurrences
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path
    else
      render 'edit'
    end
  end

  def destroy
    if @course.destroy
      redirect_to courses_path
    end
  end

  private

  def course_params
    params.require(:course).permit(:subject_id, :address_id, :start_date, :end_date, :frequency,
                                   :min_capacity, :max_capacity, :session_length, :notes)
  end

  def set_subject
    @subject = Subject.find(params[:course][:subject_id])
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
