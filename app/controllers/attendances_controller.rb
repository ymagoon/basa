class AttendancesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

  def update
    # This will only ever return a single value
    # @attendance = Attendance.where('student_id = ? AND session_id = ?', params[:student], params[:session]).first

    @attendance = Attendance.find(params[:attendance])
    @attendance.present = @attendance.present? ? 'absent' : 'present'
    @attendance.save

    render json: {"attendance": "#{@attendance.present}"}, status: 200
  end

end
