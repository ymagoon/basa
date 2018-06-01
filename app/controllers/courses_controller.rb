class CoursesController < ApplicationController
  before_action :set_subject, only: [:create]
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_view
  # before_action :average_attendance

  def index
    @courses = Course.all
    @total_course_count = @courses.size

    @course = Course.new
    @filter_subjects = Subject.all
    @filter_addresses = Address.venues

    # Filter by phase
    if params[:current].present? || params[:future].present? || params[:past].present?
      @courses_temp = Course.none
      # use or (union) to join active record relations
      @courses_temp = @courses_temp.or(@courses.current) if params[:current].present?
      @courses_temp = @courses_temp.or(@courses.future) if params[:future].present?
      @courses_temp = @courses_temp.or(@courses.past) if params[:past].present?
      @courses = @courses_temp
    end

    # Filter by location
    @courses = @courses.locations(params[:address].keys) if params[:address].present?

    # Filter by subject
    @courses = @courses.subjects(params[:subjects].keys) if params[:subjects].present?

    # Filter by status
    @courses = @courses.status(params[:status].keys) if params[:status].present?

    # Filter by misc
    @courses = @courses.with_no_teacher if params[:no_teacher].present?
    @courses = @courses.with_no_assistants if params[:no_assistants].present?

    # Sort by dates
    @courses = @courses.order_by_start_date # hard code until this is working
    # @courses = @courses.order_by_start_date if params[:sort] == 'start_date'
    # @courses = @courses.order_by_end_date if params[:sort] == 'end_date'

    # Course variables
    @course_count = @courses.size
    @subjects = @courses.subject_list
    @venues = @courses.venue_list

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @course = Course.find(params[:id])
    @students = @course.students.order(first_name: :asc)
    @sessions = @course.sessions

    # For the drop down
    @courses = Course.where(status: ['pending', 'confirmed']).select { |c| c.start_date >= DateTime.now || c.end_date <= DateTime.now }
    @teacher = @course.teacher
    @assistants = @course.assistants
  end

  def new
    @course = Course.new
    @subjects = Subject.all
    # @addresses = Address.all.select { |address| address.venue? }.map { |address| address.id } # Can refactor this using scope in model. See VolunteerRoster.
    @addresses = Address.venues
  end

  def create
    @course = Course.new(course_params)

    @subject = Subject.find(course_params[:subject_id])
    @course.subject = @subject

    @address = Address.find_by(venue_name: params[:course][:address_id])
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
    @course.destroy
  end

  private

  def course_params
    parameters = params.require(:course).permit(:name, :subject_id, :address_id, :start_date, :frequency,
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

  def set_view
    @view = "course"
  end
end
