class CoursesController < ApplicationController
  before_action :set_subject, only: [:create]
  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
    @subjects = Subject.all
    @addresses = Address.all.select { |address| address.venue? }.map { |address| address.id }
  end

  def create
    @course = Course.new(course_params)

    @subject = Subject.find(course_params[:subject_id])
    @course.subject = @subject

    @address = Address.find(course_params[:address_id])
    @course.address = @address

    # Fix logic when we add the session
    @course.number_of_sessions = 0

    if @course.save
      puts 'woo, worked!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def course_params
    params.require(:course).permit(:subject_id, :address_id, :start_date, :end_date, :frequency,
                                   :min_capacity, :max_capacity, :session_length)
  end

  def set_subject
    @subject = Subject.find(params[:course][:subject_id])
  end
end
