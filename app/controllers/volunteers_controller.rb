class VolunteersController < ApplicationController
  def index
    @volunteers = User.volunteers
  end

  def show
    @volunteer = User.find(params[:id])
  end
end
