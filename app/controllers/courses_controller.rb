class CoursesController < ApplicationController
  before_action :set_subject, only: [:create]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
    @students = Student.all
  end

  def show
    @course = Course.find(params[:id])
    @students = @course.students.order(first_name: :asc)
    @sessions = @course.sessions

    # For the drop down
    @courses = Course.where(status: ['pending', 'confirmed']).select { |c| c.start_date >= DateTime.now || c.end_date <= DateTime.now }

    respond_to do |format|
      format.html # show.html.erb
      format.js # show.js.erb
    end
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

    @course.start_date = course_params[:start_date]
    @course.end_date = course_params[:end_date]

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
    parameters = params.require(:course).permit(:subject_id, :address_id, :start_date, :frequency,
                                            :min_capacity, :max_capacity, :session_length, :notes)
    # parse date into correct format
    date = parameters[:start_date]
    parameters[:start_date] = date[0..(date.index('-') - 2)]
    parameters[:end_date] = date[(date.index('-') + 2)..-1]

    parameters
  end

  def set_subject
    @subject = Subject.find(params[:course][:subject_id])
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
