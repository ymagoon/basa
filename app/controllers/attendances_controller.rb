class AttendancesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

  def update
    @attendance = Attendance.where('student_id = ? AND session_id = ?', params[:student], params[:session])
    # puts attendance.present?

    wtf

    render :json => { :wee => 'UNKNOWN_ERROR_TYPE'}, status: 200
  end

  def wtf
    @attendance.present? ? @attendance.update(present: 'absent') : @attendance.update(present: 'present')
  end
end
